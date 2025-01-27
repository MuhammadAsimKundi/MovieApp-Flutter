import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Screens/Signin.dart';
class Moreoption extends StatelessWidget {
   Moreoption({super.key});
  final auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("About us",style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text("Welcome to our movie app, where cinematic magic meets your fingertips. Explore a world of endless entertainment, curated just for you. Join us on an unforgettable journey through the silver screen!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          TextButton(
            onPressed: () async {
                await auth.signOut();
               Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
            },
            child: Container(
              width: 320,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.yellow.shade600,
              ),
              child: const Center(
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
