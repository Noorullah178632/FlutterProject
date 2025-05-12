import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  signOut() async {
    try {
      // Log out from the Google account
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      // Handle the error
      print("Error signing out from Google account: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
      body: Center(
        child: Text(
          '${user!.email}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: signOut,
        child: Icon(Icons.login_rounded),
      ),
    );
  }
}
