import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF77BEF0),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Easing.standardDecelerate,
        animationDuration: Duration(milliseconds: 400),
        backgroundColor: Color(0XFF77BEF0),
        color: Color.fromARGB(255, 33, 127, 194),
        items: [
        Icon(Icons.check_box),
        Icon(Icons.book),
        Icon(Icons.account_box),
        ]),
    );
  }
}
