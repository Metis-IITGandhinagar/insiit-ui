import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(),
        body: const Center(
          child: Text("No Notifications Yet!!",
          style: TextStyle(fontSize: 10,
          fontWeight: FontWeight.w300),
          ),
        ));
  }
}