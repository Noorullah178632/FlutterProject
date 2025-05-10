import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
  const UpdateStudentPage({super.key, required this.id});

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  //update the data
  CollectionReference student = FirebaseFirestore.instance.collection(
    'students',
  );
  Future<void> updateUser(id, name, email, password) {
    return student
        .doc(id)
        .update({'name': name, 'email': email, 'password': password})
        .then((e) {
          Get.snackbar("Message", "The Id document has been updated");
        })
        .catchError((e) {
          Get.snackbar("Error", "$e error happened");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Student')),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future:
              FirebaseFirestore.instance
                  .collection('students')
                  .doc(widget.id)
                  .get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              Get.snackbar(
                "Error ",
                "Something went wrong while updating the data",
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var data = snapshot.data!.data();
            var name = data!['name'];
            var email = data['email'];
            var password = data['password'];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      initialValue: name,
                      autofocus: false,
                      onChanged: (value) => name = value,
                      decoration: InputDecoration(
                        labelText: 'Name: ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      initialValue: email,
                      autofocus: false,
                      onChanged: (value) => email = password,
                      decoration: InputDecoration(
                        labelText: 'Email: ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@gmail.com')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      initialValue: password,
                      autofocus: false,
                      onChanged: (value) => password = value,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password: ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              updateUser(widget.id, name, email, password);
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Reset', style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
