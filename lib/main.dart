
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import './authentication/login.dart';
// import './screens/home.dart';
// import 'package:google_fonts/google_fonts.dart';

// void main() async {

//     WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   runApp(const MyApp());
  
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder:(BuildContext context, AsyncSnapshot snapshot){
//         if(snapshot.hasError){
//           return Text(snapshot.error.toString());
//         }
//         if(snapshot.connectionState==ConnectionState.active){
//           if (snapshot.data==null) {
//             return const LoginScreen();
//           }
//           else{
//             return const HomeScreen();
//           }
//         }
//          return const Center(child: CircularProgressIndicator());
//         } ),
//       theme: ThemeData(
//         fontFamily: GoogleFonts.dmSans().fontFamily,
//         useMaterial3: true,
//         colorSchemeSeed: Colors.deepPurple[600]
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:insiit/theme/darkTheme.dart';
// import 'package:insiit/theme/lightTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './authentication/login.dart';
import './screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
// import './theme/lightTheme.dart';
// import './theme/darkTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return AdaptiveTheme(
    //   light: ThemeData.light(useMaterial3: true),
    //   dark: ThemeData.dark(useMaterial3: true),
    //   initial: AdaptiveThemeMode.light,
    //   builder: (theme, darkTheme) => MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: StreamBuilder<User?>(
    //         stream: FirebaseAuth.instance.authStateChanges(),
    //         builder: (BuildContext context, AsyncSnapshot snapshot) {
    //           if (snapshot.hasError) {
    //             return Text(snapshot.error.toString());
    //           }
    //           if (snapshot.connectionState == ConnectionState.active) {
    //             if (snapshot.data == null) {
    //               return const LoginScreen();
    //             } else {
    //               return const HomeScreen();
    //             }
    //           }
    //           return const Center(child: CircularProgressIndicator());
    //         }),
    //     theme: theme,
    //     darkTheme: darkTheme,
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        if(snapshot.connectionState==ConnectionState.active){
          if (snapshot.data==null) {
            return const LoginScreen();
          }
          else{
            return const HomeScreen();
          }
        }
         return const Center(child: CircularProgressIndicator());
        } ),
      theme: ThemeData(
        brightness: Brightness.light,
        dividerColor: Colors.transparent,
        fontFamily: GoogleFonts.dmSans().fontFamily,
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple[600]
      ),
      // theme: lightTheme,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        dividerColor: Colors.transparent,
        fontFamily: GoogleFonts.dmSans().fontFamily,
        useMaterial3: true,
        colorSchemeSeed:Colors.deepPurple[600]!,
        // colorScheme: ColorScheme.dark(
        //   surfaceTint: Colors.deepPurple[600]!,
        // background: Colors.black,
        // primary: Colors.grey[900]!,
        // secondary: Colors.grey[800]!,
        
        // )
      ),
    );
  }
}