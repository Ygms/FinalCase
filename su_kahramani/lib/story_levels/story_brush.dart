import 'package:flutter/material.dart';
import 'package:su_kahramani/story_levels/story_drink.dart';
import 'package:su_kahramani/story_levels/transition_page.dart';
import 'package:typewritertext/typewritertext.dart';

class StoryBrush extends StatelessWidget {
  final String userName;

  const StoryBrush({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
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
            "$userName sabah uyanır ve okul için hazırlanır. Okula gitmeden önce dişini fırçalamalı. \n\n"
            "Unutma, su kahramanısın. Dişlerini nasıl fırçalarsın $userName?",
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _choiceCard(
                context,
                imagePath: "assets/gifs/water.gif",
                label: "Hep açık bırak.",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransitionPage(
                        userName: userName,
                        imagePath: "assets/character/cry_main_char.png",
                        explanation:
                            "$userName dişini fırçalarken musluğu açık bırakır. "
                            "Foş foşş, bir sürü su boşa aktı! \n"
                            "Tekrar denemek ister misin",
                        nextPageBuilder: (name) => StoryBrush(userName: name),
                      ),
                    ),
                  );
                },
              ),
              _choiceCard(
                context,
                imagePath: "assets/gifs/faucet.gif",
                label: "Dişini fırçalarken kapat.",
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransitionPage(
                        userName: userName,
                        imagePath: "assets/gifs/happy_teeth.gif",
                        explanation:
                            "$userName dişini fırçalarken suya dikkat eder. \n"
                            "Dişlerin temiz! Kalbin de öyle! \n",
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
