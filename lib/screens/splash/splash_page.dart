import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_final/screens/auth/login_page.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: LoginPage(),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 500))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  width: (height.toInt() / 4),
                  height: (height.toInt() / 4),
                  fit: BoxFit.cover,
                  image: AssetImage('asset/images/ava.jpg'),
                ),
              ),
              Text(
                "RentalZ",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
