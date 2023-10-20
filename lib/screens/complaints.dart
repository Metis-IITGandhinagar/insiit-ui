import 'package:flutter/material.dart';

class ComplainsPage extends StatefulWidget {
  const ComplainsPage({super.key});

  @override
  State<ComplainsPage> createState() => _ComplainsPageState();
}

class _ComplainsPageState extends State<ComplainsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           centerTitle: true,
          title: Text("Complaints"),
        ),
        body: const Center(
          child: Text(
            "Your Complaint Page",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
          ),
        ));
  }
}
