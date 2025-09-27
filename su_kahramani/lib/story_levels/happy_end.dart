import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:su_kahramani/home_page.dart';

class StoryEnds extends StatefulWidget {
  final String userName;

  const StoryEnds({super.key, required this.userName});

  @override
  _StoryEndsState createState() => _StoryEndsState();
}

class _StoryEndsState extends State<StoryEnds> {
  final int currentLevel = 4;



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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset("assets/gifs/celebration.gif", height: 200, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              Text(
                "🎉 Tebrikler ${widget.userName}! Bir damla bile su harcamadın. İşte gerçek bir Su Kahramanı! 🌟💧",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Grandstander",
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Hikayeyi bitir.",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Grandstander",
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}