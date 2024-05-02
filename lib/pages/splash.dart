import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nibba/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() { 
    super.initState(); 
    Timer(Duration(seconds: 3), 
          ()=>Navigator.pushReplacement(context, 
                                        MaterialPageRoute(builder: 
                                                          (context) =>  
                                                          HomePage() 
                                                         ) 
                                       ) 
         ); 
  } 
  @override
  Widget build(BuildContext context) {
    return  Container( 
      color: Colors.white, 
      child:FlutterLogo(size:MediaQuery.of(context).size.height) 
    );
  }
}