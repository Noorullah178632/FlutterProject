import 'package:android_firebase/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VarifyEmail extends StatefulWidget {
  const VarifyEmail({super.key});
  @override
  State<VarifyEmail> createState() => VarifyEmailState();
}

class VarifyEmailState extends State<VarifyEmail> {
  @override
  void initState() {
    sendVarifyLink();
    super.initState();
  }

  sendVarifyLink() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification().then(
      (value) => {
        Get.snackbar('Link sent', "A link has been send to your email "),
      },
    );
  }

  reload() async {
    try {
      await FirebaseAuth.instance.currentUser!.reload().then((value) {
        Get.offAll(Wrapper());
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Message', e.code);
    } catch (e) {
      Get.snackbar('Error Message', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Varification')),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Text(
            'Open your mail and click on the link provided to verify email and reload this page.',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          reload();
        },
        child: Icon(Icons.restart_alt_outlined),
      ),
    );
  }
}
