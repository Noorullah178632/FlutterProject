import 'package:ecommerce_app/app_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyAppState();
}

class _MyAppState extends State<HomeScreen> {
  int SelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List pages = [AppHomeScreen(), Scaffold(), Scaffold(), Scaffold()];
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        unselectedItemColor: Colors.black45,
        currentIndex: SelectedIndex,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {});
          SelectedIndex = value;
        },
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.setting),
            label: 'setting',
          ),
        ],
      ),
      body: pages[SelectedIndex],
    );
  }
}
