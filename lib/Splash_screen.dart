import 'dart:async';

import 'package:flutter/material.dart';
import 'package:technical_task/Login_page.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Login_Page();
        },
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 175,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/splash_icon.png"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
