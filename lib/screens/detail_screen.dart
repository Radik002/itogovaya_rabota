import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:itogovaya_rabota/global_theme.dart';

import 'main_page.dart';

class DetailScreen extends StatefulWidget {
  User? user;

  DetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class ToDo {
  final bool completed;
  final int id;
  final String title;
  final int userId;

  ToDo({required this.completed, required this.id, required this.title, required this.userId});

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      completed: json['completed'],
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
    );
  }

}

class _DetailScreenState extends State<DetailScreen> {

  late List<ToDo> todo;

  Future<List<ToDo>> _fetchToDoList(int id) async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos?userId=$id"));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => ToDo.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  ListView _usersToDoView(List<ToDo> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 10,
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(data[index].title,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        textStyle: Theme.of(context).textTheme.headline5)),
                leading: Checkbox(onChanged: (bool? value) {  }, value: data[index].completed,
                  
                )
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('Подробнее',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    textStyle: Theme.of(context).textTheme.headline5))),
        body: Column(children: [
          Container(
            width: double.infinity,
            child: Card(
              elevation: 10,
              color: Colors.lightBlue,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          child: Icon(Icons.person),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(widget.user?.name ?? "",    style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            textStyle: Theme.of(context).textTheme.bodyText1))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("Company name: ${widget.user?.company.name}"),
                            Divider(),
                            Text(
                                "Phrase:\n${widget.user?.company.catchPhrase}"),
                            Divider(),
                            Text("BS: ${widget.user?.company.bs}"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.control_point),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Street: ${widget.user?.address.street}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.control_point),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Suite: ${widget.user?.address.suite}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.control_point),
                              SizedBox(
                                width: 30,
                              ),
                              Text("City: ${widget.user?.address.city}"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.control_point),
                              SizedBox(
                                width: 40,
                              ),
                              Text("ZipCode: ${widget.user?.address.zipcode}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          FutureBuilder<List<ToDo>>(
              future: _fetchToDoList(widget.user?.id ?? 0),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  todo = snapshot.data!;
                  return Expanded(child: _usersToDoView(todo));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              })
        ]),
      ),
    );
  }
}
