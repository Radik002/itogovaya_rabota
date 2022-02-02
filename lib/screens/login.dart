import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:itogovaya_rabota/screens/detail_screen.dart';
import 'package:itogovaya_rabota/global_theme.dart';
import 'package:itogovaya_rabota/screens/main_page.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nol = 'Неверный логин';
    var nop = 'Неверный пароль';
    final _formKey = GlobalKey<FormState>();


    const borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(18.0)),
      borderSide: BorderSide(color: Colors.green, width: 2),
    );
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.lightBlueAccent,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Diplom',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                              fontSize: 50)),
                      TextSpan(
                          text: 'Work',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 50))
                    ])),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value != 'mail@mail.ru') {
                          return nol;
                        }
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.mail,
                            color: Colors.yellow,
                          ),
                          hintText: 'mail@mail.ru',
                          enabledBorder: borderStyle,
                          focusedBorder: borderStyle,
                          errorBorder: borderStyle,
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value != '123') {
                          return nop;
                        }
                      },
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Colors.yellow,
                          ),
                          enabledBorder: borderStyle,
                          focusedBorder: borderStyle,
                          errorBorder: borderStyle,
                          filled: true,
                          hintText: '123',
                          fillColor: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, '/home');
                          }
                        },
                        child: const Text(
                          'Войти',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

