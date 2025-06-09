import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:insiit/widgets/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './authentication/login.dart';
import './screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  } catch (e) {
    print("Failed to initialize Firebase: $e");
  }

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == null) {
                return const LoginScreen();
              } else {
                return const HomeScreen();
              }
            }
            return const Center(child: CircularProgressIndicator());
          }),
      theme: ThemeData(
          brightness: Brightness.light,
          dividerColor: Colors.transparent,
          fontFamily: GoogleFonts.dmSans().fontFamily,
          useMaterial3: true,
          colorSchemeSeed: Colors.deepPurple),
      // theme: lightTheme,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        dividerColor: Colors.transparent,
        fontFamily: GoogleFonts.dmSans().fontFamily,
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple!,
      ),
    );
  }
}
