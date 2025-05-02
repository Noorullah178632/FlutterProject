import 'package:android_firebase/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //two textfield
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  // var for obsuretext
  bool _obsecuretext = true;
  // create method for signUP
  Signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Get.to(Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error message', e.code);
    } catch (e) {
      Get.snackbar('Error message', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: email,
            decoration: InputDecoration(
              hintText: 'Email',
              suffixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: password,
            obscureText: _obsecuretext,
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obsecuretext = !_obsecuretext;
                  });
                },
                icon: Icon(
                  _obsecuretext ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: Signup, child: Text('SignUp')),
        ],
      ),
    );
  }
}
