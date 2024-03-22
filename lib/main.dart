import "package:flutter/material.dart";
import "package:nibba/pages/home_page.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple.shade400,
        fontFamily: 'dekko'
      ),
    );
  }
}