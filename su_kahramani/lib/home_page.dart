import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 172, 226, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 141, 218),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white)
        ),
        child: CurvedNavigationBar(
          animationCurve: Easing.standardDecelerate,
          animationDuration: Duration(milliseconds: 400),
          backgroundColor: Color.fromARGB(255, 172, 226, 255),
          color: Color.fromARGB(255, 0, 141, 218),
          items: [
            Icon(Icons.check_box, size: 30,),
            Icon(Icons.book, size: 30,),
            Icon(Icons.account_circle, size: 30,),
          ],
        ),
      ),
    );
  }
}
