import 'package:flutter/material.dart';
import './views/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TicTacToe",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF222428),
        canvasColor: const Color(0xFF25282d),
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Color(0xFFbababa),
            fontSize: 17,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
