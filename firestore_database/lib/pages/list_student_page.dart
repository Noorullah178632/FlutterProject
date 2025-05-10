import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_database/pages/update_student_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({super.key});

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentStream =
      FirebaseFirestore.instance.collection('students').snapshots();
  // for deleting the document
  CollectionReference student = FirebaseFirestore.instance.collection(
    'students',
  );
  Future<void> delteUser(id) {
    return student
        .doc(id)
        .delete()
        .then((e) {
          Get.snackbar('Message', "$id has been deleted ");
        })
        .catchError((value) {
          Get.snackbar("Error Message", value);
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: studentStream,
      //AsyncSnapshot:A state of async data which could be in different state like waiting, error,done
      //querysnapshot: contain the result of firestore query , like cotain the collection data i.e documentation
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print("something went wrong");
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data found'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        // we will make a empty list in which we have to add the data
        final List storedocs = [];
        // now we have to fetch the data from the documentation
        //do you see that place DocumentSnapshot documentData:in here document data we have the id of the document with the help of which we can delete the document
        snapshot.data!.docs.map((DocumentSnapshot documentData) {
          Map<String, dynamic> a = documentData.data() as Map<String, dynamic>;
          a['id'] = documentData.id;
          storedocs.add(a);
        }).toList();
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(),
              columnWidths: <int, TableColumnWidth>{1: FixedColumnWidth(170)},
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        child: Center(
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        child: Center(
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        child: Center(
                          child: Text(
                            'Action',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                for (int i = 0; i < storedocs.length; i++) ...[
                  TableRow(
                    children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            storedocs[i]['name'],
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            storedocs[i]['email'],
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => UpdateStudentPage(
                                          id: storedocs[i]['id'],
                                        ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit, color: Colors.orange),
                            ),
                            IconButton(
                              onPressed: () {
                                delteUser(storedocs[i]['id']);
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
