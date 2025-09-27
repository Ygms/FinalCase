import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:su_kahramani/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final savedName = prefs.getString('playerName');



  runApp(MyApp(initialName: savedName));
}

class MyApp extends StatelessWidget {
  final String? initialName;

  const MyApp({Key? key, this.initialName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(initialName: initialName),
    );
  }
}