import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:typewritertext/typewritertext.dart';

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
        backgroundColor: Color.fromARGB(255, 138, 205, 215),
        title: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 3.0,
                colors: [
                  Color.fromARGB(255, 0, 162, 206),
                  Color.fromARGB(255, 138, 205, 215),
                ],
              ),
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Text(
              "Su Kahramanı",
              style: TextStyle(
                fontFamily: "Grandstander",
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),

      body: Center(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.all(10.0),
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(255, 50, 50, 89),
                ),
                child: TypeWriter.text(
                  "Merhaba, <kullanıcı adı>! \n Su Kahramanı olmak ister misin?",
                  maintainSize: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0, fontFamily: "Grandstander", color: Colors.white),
                  duration: const Duration(milliseconds: 50),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 400,
                width: 450,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/character/main_char.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: 50,
                width: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 50, 50, 89),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(255, 50, 50, 89),

                  gradient: RadialGradient(
                    radius: 3.0,
                    colors: [
                      Color.fromARGB(255, 190, 241, 255),
                      Color.fromARGB(255, 0, 162, 206),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    "Hikayeye Başla",
                    style: TextStyle(
                      color: Color.fromARGB(255, 50, 50, 89),
                      fontFamily: "Grandstander",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(
          context,
        ).copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          animationCurve: Easing.standardDecelerate,
          buttonBackgroundColor: Color.fromARGB(255, 0, 162, 206),
          animationDuration: Duration(milliseconds: 400),
          backgroundColor: Color.fromARGB(255, 224, 244, 255),
          color: Color.fromARGB(255, 138, 205, 215),
          items: [
            Icon(Icons.check_box, size: 30),
            SvgPicture.asset('assets/drop.svg', width: 35, height: 35),
            Icon(Icons.account_circle, size: 30),
          ],
        ),
      ),
    );
  }
}
