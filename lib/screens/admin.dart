import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:insiit/constants.dart';
import 'package:insiit/screens/create_event.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    final firebaseAuthInstance = FirebaseAuth.instance;
    final user = firebaseAuthInstance.currentUser;
    if (user == null) {
      return Scaffold(
          appBar: AppBar(title: const Text("Admin")),
          body: const Center(
              child: Text(
                  "You need to log in with authorized email to access this menu")));
    } else {
      return Scaffold(
          appBar: AppBar(title: const Text("Admin")),
          body: Center(
              child: FutureBuilder(
                  future: getAuthorizedRoutes(user),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Couldn't get admin from route ");
                    } else if (snapshot.hasData) {
                      final admin = snapshot.data!;
                      final adminRoutes = admin["adminRoutes"];
                      print(snapshot.data!);
                      return Column(children: [
                        adminRoutes.contains("createEvent")
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CreateEventPage(user: user);
                                  }));
                                },
                                child: const Text("Create event"))
                            : Container(),
                      ]);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  })));
    }
  }

  Future<Map<String, dynamic>> getAuthorizedRoutes(User user) async {
    print("HI");
    final token = user.uid;
    final response = await http.get(Uri.parse("$API_BASE_URL/admin"),
        headers: <String, String>{"Authorization": "Bearer $token"});
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      return jsonBody;
    } else {
      throw "Couldn't get admin: ${response.body}";
    }
  }
}
