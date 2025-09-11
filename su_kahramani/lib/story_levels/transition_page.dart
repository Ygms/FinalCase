import 'package:flutter/material.dart';

class TransitionPage extends StatelessWidget {
  final String userName;
  final String imagePath;
  final String explanation;
  final Widget Function(String userName) nextPageBuilder;

  const TransitionPage({
    super.key,
    required this.userName,
    required this.imagePath,
    required this.explanation,
    required this.nextPageBuilder,
  });

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
                child: Image.asset(imagePath, height: 200, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              Text(
                explanation,
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
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => nextPageBuilder(userName),
                    ),
                  );
                },
                child: const Text(
                  "Devam Et.",
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
