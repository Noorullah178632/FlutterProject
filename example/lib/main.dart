import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drawer Example")),

      drawer: Drawer(
        // ← This is the drawer
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 30),
              child: TextButton(onPressed: () {}, child: Text('show')),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 30),
              child: TextButton(onPressed: () {}, child: Text('show')),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 30),
              child: TextButton(onPressed: () {}, child: Text('show')),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 30),
              child: TextButton(onPressed: () {}, child: Text('show')),
            ),
          ],
        ),
      ),

      body: Center(child: Text("Swipe from left or tap the menu icon")),
    );
  }
}
