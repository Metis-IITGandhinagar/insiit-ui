import 'package:flutter/material.dart';
import 'package:insiit/widgets/home.dart';
import 'package:insiit/widgets/more.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import './authentication/login.dart';
import './screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  AwesomeNotifications().initialize(null,[
    NotificationChannel(channelKey: 'basic_channel', channelName: "InsIIT Notification", channelDescription: "Default Notification Channel for InsIIT")
  ],
  debug: true);
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
        fontFamily: GoogleFonts.dmSans().fontFamily,
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple[600]
      ),
    );
  }
}

