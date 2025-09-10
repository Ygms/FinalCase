import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:su_kahramani/story_page.dart';
import 'package:typewritertext/typewritertext.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 1;
  String _userName = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Center(child: Text("Görevler", style: TextStyle(fontSize: 24))), //bunlar
      Center(
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          scrollDirection: Axis.vertical,
          children: [Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_speechText(), _mainCharImg(_animation), _startButton()],
          ),]
        ),
      ),
      Center(
        child: Text("Profil", style: TextStyle(fontSize: 24)),
      ), //düzenlencek
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 224, 244, 255),
      appBar: _appBar(),

      body: pages[_currentIndex],

      bottomNavigationBar: _navigationBar(context),
    );
  }

  Center _mainCharImg(Animation<double> animation) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, animation.value),
            child: child,
          );
        },
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
    );
  }

  Center _startButton() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          if(_userName.isEmpty){ String? name = await showDialog<String>(
            context: context,
            builder: (context) {
              String tempName = "";
              return AlertDialog(
                title: Text("Adın Nedir?", style: TextStyle(fontFamily: "Grandstander"),),
                content: TextField(
                  onChanged: (value) {
                    tempName = value;
                  },
                  decoration: InputDecoration(hintText: "Damla"),
                  style: TextStyle(fontFamily: "Grandstander"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("İptal", style: TextStyle(fontFamily: "Grandstander"),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, tempName);
                    },
                    child: Text("Tamam", style: TextStyle(fontFamily: "Grandstander"),),
                  ),
                ],
              );
            },
          );
          if(name != null && name.isNotEmpty) {
            setState(() {
              _userName = name[0].toUpperCase()+name.substring(1).toLowerCase();
            });

            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => StoryPage(userName: _userName)),
            );
          }
        }
        else if(_userName.isNotEmpty){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => StoryPage(userName: _userName)));
        }
        
        },
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

            //color: Color.fromARGB(255, 50, 50, 89),
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
    );
  }

  Center _speechText() {
    return Center(
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
          _userName.isEmpty
              ? "Merhaba! \n Su Kahramanı olmak ister misin?"
              : "Merhaba $_userName! \n Su Kahramanı olmak ister misin?",
          maintainSize: true,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            fontFamily: "Grandstander",
            color: Colors.white,
          ),
          duration: const Duration(milliseconds: 50),
        ),
      ),
    );
  }

  Theme _navigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(iconTheme: IconThemeData(color: Colors.white)),
      child: CurvedNavigationBar(
        index: _currentIndex,
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 138, 205, 215),
      title: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.0),
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
