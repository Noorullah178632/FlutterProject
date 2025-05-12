import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _WrapperState();
}

class _WrapperState extends State<Login> {
  login() async {
    // purpose:ask the user to pick a google account and sign In , and save the selected account
    //GoogleSignInAccount is a class.which store the user name,email address,and ID etc.
    //GoogleSignIn() is a constructor of GoogleSignIn class.help with login and log out account
    //signIn() is a method in GoogleSignIn class .it ask user to choose a account to log in
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //purpose:it get the authentication tokens from the logged In google account.these token are needed to varify the user and connect with the firebas.
    //GoogleSignInAuthentication is a class and it's hold the tokens you get after sign in with google account.
    //googleUser?.authentication mean that it safely get the login tokens of the user.
    //one hold the tokens and other get the tokens
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    //purpose:varify the user into firebase.
    //GoogleAuthProvider is a class in firebase that help with Google Authentication.
    //credential is a method of GoogleAuthProvider , it a token or key
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    //purpose:it take the credentail and logs the user into firebase.
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: login,
          icon: FaIcon(FontAwesomeIcons.google),
          label: Text(
            'Sign In with Google',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
