import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "InsIIT",
                      style: Theme.of(context).textTheme.displayMedium,
                      // style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 40,
                      //    ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("All things IITGN",
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer),
            onPressed: () => googleSignIn(),
            child: Text(
              'Login with IITGN email',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiaryContainer),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 15,
            child: Text("or"),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer),
              onPressed: () => signInAnonymously(),
              child: Text(
                'Guest Mode',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer),
              )),
          const SizedBox(height: 150),
          const Text(
            "Made with ♥️ by Metis, IITGN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

googleSignIn() async {
  GoogleSignInAccount? googleUser =
      await GoogleSignIn(hostedDomain: 'iitgn.ac.in').signIn();

  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
  // print(userCredential.user);
}

signInAnonymously() async {
  try {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    // print("Signed in with temporary account.");
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        // print("Anonymous auth hasn't been enabled for this project.");
        break;
      default:
      // print("Unknown error.");
    }
  }
}
