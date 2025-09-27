import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:su_kahramani/story_levels/happy_end.dart';
import 'package:su_kahramani/story_levels/transition_page.dart';
import 'package:typewritertext/typewritertext.dart';

class StoryFlower extends StatefulWidget {
  final String userName;


  const StoryFlower({super.key, required this.userName});

  @override
  _StoryFlowerState createState() => _StoryFlowerState();
}

class _StoryFlowerState extends State<StoryFlower> {
  final int currentLevel = 3; // StoryFlower seviye 3



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () async {
            Navigator.popUntil(context, (route) => route.isFirst); // Ana sayfaya dön
          },
        ),
        centerTitle: true,
        title: Text(
          "Su Kahramanı Macerası",
          style: TextStyle(
            fontFamily: "Grandstander",
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.blue.shade100,
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          bottom: 16.0,
          left: 16.0,
          right: 16.0,
          top: 50,
        ),
        children: [
          _storyTeller(
            "${widget.userName} okuldan eve geldi ve babası ona saksıdaki çiçekleri sulamasını söyledi. 🌸💧 \n\n"
                "Peki ${widget.userName}, çiçekleri sulamak için hangi seçeneği tercih edecek? 🤔",
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _choiceCard(
                context,
                imagePath: "assets/gifs/suluk.gif",
                label: "Suluk",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransitionPage(
                        userName: widget.userName,
                        imagePath: "assets/gifs/happy_pot.gif",
                        explanation:
                        "${widget.userName} çiçekleri sulukla özenle suladı. 🌱💧 "
                            "Tıpkı gerçek bir Su Kahramanı gibi! 🌟 \n",
                        nextPageBuilder: (name) => StoryEnds(userName: name),
                      ),
                    ),
                  );
                },
              ),
              _choiceCard(
                context,
                imagePath: "assets/gifs/hose.gif",
                label: "Bahçe Hortumu",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransitionPage(
                        userName: widget.userName,
                        imagePath: "assets/gifs/sad pot.gif",
                        explanation:
                        "${widget.userName} çiçekleri hortumla suladı. 💦🌸 \n"
                            "Çiçekler neredeyse suyun içinde yüzüyor! 😬 Pek mutlu görünmüyorlar. \n"
                            "Tekrar denemek ister misin?",
                        nextPageBuilder: (name) => StoryFlower(userName: name),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _storyTeller(String txt) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.blue.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TypeWriter.text(
          txt,
          key: ValueKey(txt),
          maintainSize: true,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            fontFamily: "Grandstander",
            color: Colors.black87,
            height: 1.4,
          ),
          duration: const Duration(milliseconds: 40),
        ),
      ),
    );
  }

  Widget _choiceCard(
      BuildContext context, {
        required String imagePath,
        required String label,
        required VoidCallback onTap,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imagePath, height: 120, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Grandstander",
              ),
            ),
          ],
        ),
      ),
    );
  }
}