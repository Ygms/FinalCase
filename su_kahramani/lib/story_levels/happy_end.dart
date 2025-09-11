import 'package:flutter/material.dart';

class StoryEnds extends StatelessWidget {
  final String userName;

  const StoryEnds({super.key, required this.userName});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HEyyoo")),
    );
  }
  
  }