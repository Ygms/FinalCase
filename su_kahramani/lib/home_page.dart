import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:su_kahramani/story_levels/story_brush.dart';
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
  bool? _value1 = false;
  bool? _value2 = false;
  bool? _value3 = false;

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
      Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _speechText(
                  _userName.isEmpty
                      ? "Hey, senin için günlük plan hazırladım. \n Her gün tamamla, \n her gün kahraman ol!"
                      : "Hey $_userName, senin için günlük plan hazırladım. \n Her gün tamamla, \n her gün kahraman ol!",
                  150,
                  300,
                ),
                _mainCharImg(_animation, "assets/character/world_joyful.png"),

                _checkList(),
              ],
            ),
          ],
        ),
      ), 
      Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _speechText(
                  _userName.isEmpty
                      ? "Merhaba! \n Su Kahramanı olmaya hazır mısın?"
                      : "Merhaba $_userName! \n Su Kahramanı olmaya hazır mısın?",
                  100,
                  300,
                ),
                _mainCharImg(_animation, "assets/character/main_char.png"),
                _startButton(),
              ],
            ),
          ],
        ),
      ),
      Center(
        child: Text("Profil", style: TextStyle(fontSize: 24)),
      ), 
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 224, 244, 255),
      appBar: _appBar(),

      body: pages[_currentIndex],

      bottomNavigationBar: _navigationBar(context),
    );
  }

  Column _checkList() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            const SizedBox(width: 10),
            Checkbox(
              value: _value1,
              onChanged: (bool? newValue) {
                setState(() {
                  _value1 = newValue;
                });
              },
              checkColor: Colors.white,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return Color.fromARGB(255, 50, 50, 89);
                }
                return Colors.white;
              }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Dişimi fırçalarken çeşmeyi kapattım.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Grandstander",
                  decoration: _value1 == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationThickness: 5,
                  decorationColor: Color.fromARGB(255, 50, 50, 89),
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            const SizedBox(width: 10),
            Checkbox(
              value: _value2,
              onChanged: (bool? newValue) {
                setState(() {
                  _value2 = newValue;
                });
              },
              checkColor: Colors.white,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return Color.fromARGB(255, 50, 50, 89);
                }
                return Colors.white;
              }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Bol su içtim ve hiç dökmedim.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Grandstander",
                  decoration: _value2 == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationThickness: 5,
                  decorationColor: Color.fromARGB(255, 50, 50, 89),
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            const SizedBox(width: 10),
            Checkbox(
              value: _value3,
              onChanged: (bool? newValue) {
                setState(() {
                  _value3 = newValue;
                });
              },
              checkColor: Colors.white,
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return Color.fromARGB(255, 50, 50, 89);
                }
                return Colors.white;
              }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Banyo yaparken iyice temizlendim ve suya dikkat ettim.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Grandstander",
                  decoration: _value3 == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationThickness: 5,
                  decorationColor: Color.fromARGB(255, 50, 50, 89),
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Center _mainCharImg(Animation<double> animation, String path) {
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
              image: AssetImage(path),
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
          if (_userName.isEmpty) {
            String? name = await showDialog<String>(
              context: context,
              builder: (context) {
                String tempName = "";
                return AlertDialog(
                  title: Text(
                    "Adın Nedir?",
                    style: TextStyle(fontFamily: "Grandstander"),
                  ),
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
                      child: Text(
                        "İptal",
                        style: TextStyle(fontFamily: "Grandstander"),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, tempName);
                      },
                      child: Text(
                        "Tamam",
                        style: TextStyle(fontFamily: "Grandstander"),
                      ),
                    ),
                  ],
                );
              },
            );
            if (name != null && name.isNotEmpty) {
              setState(() {
                _userName =
                    name[0].toUpperCase() + name.substring(1).toLowerCase();
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryBrush(userName: _userName),
                ),
              );
            }
          } else if (_userName.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoryBrush(userName: _userName),
              ),
            );
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

  Center _speechText(String txt, double hght, double wdth) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.all(10.0),
        height: hght,
        width: wdth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromARGB(255, 50, 50, 89),
        ),
        child: TypeWriter.text(
          txt,
          key: ValueKey(txt),
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
