import 'package:android_firebase/resetpass.dart';
import 'package:android_firebase/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  //two text editing controller
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  //method for sign in
  SignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error message', e.code);
    } catch (e) {
      Get.snackbar('Error message', e.toString());
    }
  }

  // variable for password
  bool _obsecureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Email and password')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: email,

            decoration: InputDecoration(
              hintText: 'Email',
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.email)),
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: password,
            obscureText: _obsecureText,
            decoration: InputDecoration(
              hintText: 'password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obsecureText = !_obsecureText;
                  });
                },
                icon: Icon(
                  _obsecureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: SignIn, child: Text('Login')),
          SizedBox(height: 10),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'if you do not have any account click on : ',
                  style: TextStyle(color: Colors.black26),
                ),
                TextSpan(
                  text: 'Sign Up ',
                  style: TextStyle(color: Colors.blueAccent),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          Get.off(Signup());
                        },
                ),
                TextSpan(
                  text: 'Else ',
                  style: TextStyle(color: Colors.black26),
                ),
                TextSpan(
                  text: 'Forgot Password ?',
                  style: TextStyle(color: Colors.blue),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(Resetpass());
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
