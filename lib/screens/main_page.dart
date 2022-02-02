import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itogovaya_rabota/global_theme.dart';
import 'package:http/http.dart' as http;
import 'package:itogovaya_rabota/nav.dart';
import 'package:itogovaya_rabota/screens/detail_screen.dart';
import 'package:itogovaya_rabota/screens/main_page.dart';

Future<List<User>> _fetchUsersList() async {
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}

ListView _usersListView(List<User> data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DetailScreen(user: data[index],)));
          },
          child: Card(
            elevation: 10,
            margin: EdgeInsets.all(10),
            child:
              ListTile(
                title: Text(data[index].name,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        textStyle: Theme.of(context).textTheme.bodyText2)),
                subtitle: Text(data[index].email, style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    textStyle: Theme.of(context).textTheme.bodyText1),),
                leading: Icon(
                  Icons.person,
                ),
              )
          ),
        );
      });
}


class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;

  Address({
    required this.city,
    required this.street,
    required this.suite,
    required this.zipcode
  });
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json["city"],
      street: json['street'],
      suite: json['suite'],
      zipcode: json['zipcode'],
    );
  }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.bs,
    required this.name,
    required this.catchPhrase,
  });
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      catchPhrase: json["catchPhrase"],
      name: json['name'],
      bs: json['bs'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Company company;
  final Address address;

  User({
    required this.company,
    required this.username,
    required this.id,
    required this.name,
    required this.email,
    required this.address
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      company: Company.fromJson(json["company"]),
      address: Address.fromJson(json["address"]),
      username: json["username"],
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late List<User> users;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        drawer: navigationDrawer(),
        appBar: AppBar(
          centerTitle: true,
            title: Text('Пользователи',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    textStyle: Theme.of(context).textTheme.headline5))),
        body: Center(
          child: FutureBuilder<List<User>>(
              future: _fetchUsersList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  users = snapshot.data!;
                  return _usersListView(users);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
