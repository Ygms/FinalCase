import 'package:flutter/material.dart';

class StoryEnds extends StatelessWidget {
  final String userName;

  const StoryEnds({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
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
                "Tebrikler $userName. Suyu hiç harcamadın. Gerçek bir su kahramanısın.",
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12),
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
