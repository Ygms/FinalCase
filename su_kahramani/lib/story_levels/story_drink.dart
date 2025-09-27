import 'package:flutter/material.dart';
import 'package:su_kahramani/story_levels/story_flower.dart';
import 'package:su_kahramani/story_levels/story_wash.dart';
import 'package:su_kahramani/story_levels/transition_page.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryDrink extends StatefulWidget {
  final String userName;


  const StoryDrink({super.key, required this.userName});

  @override
  _StoryDrinkState createState() => _StoryDrinkState();
}

class _StoryDrinkState extends State<StoryDrink> {
  final int currentLevel = 1;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () async {
            Navigator.popUntil(context, (route) => route.isFirst);
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
            "${widget.userName} okula gitmeden önce susadı ve su içmek istedi. Çünkü su, vücudu zinde tutar ve sağlığa çok iyi gelir. 🚰✨ ${widget.userName} musluğun başına geldi. \n\n"
                "Peki, suyu nasıl içeceksin? Kararın çok önemli! 🌟?",
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _choiceCard(
                context,
                imagePath: "assets/gifs/fill.gif",
                label: "Bardağını güzelce doldur ve suyunu son damlasına kadar iç. 💧",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransitionPage(
                        userName: widget.userName,
                        imagePath: "assets/character/hug_world.png",
                        explanation:
                        "${widget.userName} bardağındaki suyu dökmeden içti ve susuzluğunu giderdi. 💧 \n"
                            "Ne kadar sağlıklı ve duyarlı bir seçim! 🌟 Artık enerjinle okula gitmeye hazırsın! 🎒",
                        nextPageBuilder: (name) => StoryWash(userName: name),

                      ),
                    ),
                  );
                },
              ),
              _choiceCard(
                context,
                imagePath: "assets/gifs/pour.gif",
                label: "Bardağı doldur ama içmediğin suyu döküp israf et. 😟",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransitionPage(
                        userName: widget.userName,
                        imagePath: "assets/character/cry_main_char.png",
                        explanation:
                        "${widget.userName} bardakta fazla su aldı ve kalanını döktü. 💦 \n"
                            "Oysa kalan suyu çiçeklere verebilirdi, hem doğayı hem de ailesini mutlu edebilirdi! 🌱 \n"
                            "Hadi, su kahramanı olma şansını tekrar denemek ister misin? 🌟",
                        nextPageBuilder: (name) => StoryDrink(userName: name),
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