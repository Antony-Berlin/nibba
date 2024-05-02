import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nibba/pages/home_page.dart';

class initPage extends StatefulWidget {
  const initPage({super.key});

  @override
  State<initPage> createState() => _initPageState();
}

class _initPageState extends State<initPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
                        height: 100,
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xff7b70ee),
                        ),
                        child: const Center(
                          child: Text(
                            "Nibba",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFfefefe),
                                fontSize: 35,
                                fontFamily: 'dekko'),
                          ),
                        ),
                      ),
            Center(
              child: Column(
                children: [
                  // ElevatedButton(onPressed: onPressed, child: child)
                ]
              ),
            )
          ]
        ),
      ),
    );
  }
}