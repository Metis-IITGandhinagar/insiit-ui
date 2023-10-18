import 'package:flutter/material.dart';

import './authentication/login.dart';
import './screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      theme: ThemeData(
        hintColor: const Color.fromARGB(198, 161, 126, 18),
      ),
    );
  }
}
