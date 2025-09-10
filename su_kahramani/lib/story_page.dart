import 'package:flutter/material.dart';

class StoryPage extends StatelessWidget {
  final String userName;

  const StoryPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hikaye Sayfası"),
      ),
    );
  }
}
