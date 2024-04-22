import "package:flutter/material.dart";
import "package:nibba/pages/home_page.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF584cd7),
        fontFamily: 'dekko'
      ),
    );
  }
}