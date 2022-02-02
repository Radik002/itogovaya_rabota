
import 'package:flutter/material.dart';
import 'package:itogovaya_rabota/screens/detail_screen.dart';
import 'package:itogovaya_rabota/global_theme.dart';
import 'package:itogovaya_rabota/screens/login.dart';
import 'package:itogovaya_rabota/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/detail': (context) => DetailScreen(user: null,),
        '/home': (context) => const MyHomePage(),
        '/login': (context) => const Login(),
      },
      title: 'Дипломная работа',
      theme: globalTheme(),
      home: Login(),
    );
  }
}

