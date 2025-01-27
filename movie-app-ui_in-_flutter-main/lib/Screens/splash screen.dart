import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'Signin.dart';

class Splas_screen extends StatefulWidget {
  const Splas_screen({super.key});
  @override
  _Splas_screenState createState() => _Splas_screenState();
}
class _Splas_screenState extends State<Splas_screen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/logo.png"),
              backgroundColor: Colors.transparent,
              radius: 45,
            ),
            const SizedBox(height: 20),
            Container(
              width: 200, // Set the desired width here
              child:  LinearProgressIndicator(
                color: Colors.yellow,
                minHeight: 3,
                backgroundColor: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

