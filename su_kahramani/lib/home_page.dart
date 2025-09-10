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
      backgroundColor: Color.fromARGB(255, 224, 244, 255),


      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 196, 255),
        title: Center(
          child: Text("Su kahramanı", style: TextStyle(
            fontSize: 30,
            color: Colors.white
          )),
        ),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white)
        ),
        child: CurvedNavigationBar(
          animationCurve: Easing.standardDecelerate,
          buttonBackgroundColor: Color.fromARGB(255, 57, 167, 255),
          animationDuration: Duration(milliseconds: 400),
          backgroundColor: Color.fromARGB(255, 224, 244, 255),
          color: Color.fromARGB(255, 135, 196, 255),
          items: [
            Icon(Icons.check_box, size: 30),
            SvgPicture.asset('assets/drop.svg', width: 35, height: 35),
            Icon(Icons.account_circle, size: 30,),
          ],
        ),
      ),
    );
  }
}
