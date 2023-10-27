
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("InsIIT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("All things IITGN", style: TextStyle(fontSize: 20)),
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
              backgroundColor: const Color.fromARGB(255, 255, 229, 229),
            ),
            onPressed: () => googleSignIn(),
            child: const Text('Login with IITGN email',style: TextStyle(color: Color.fromRGBO(198, 40, 40, 1)),),
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
              backgroundColor: Colors.blue[200],
            ),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false),
            child: const Text('Login as Guest'),
          ),
        ],
      ),
    );
  }
}

googleSignIn() async{

GoogleSignInAccount? googleUser = await GoogleSignIn(hostedDomain: 'iitgn.ac.in').signIn();

GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken
  );
UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
print(userCredential.user);

}