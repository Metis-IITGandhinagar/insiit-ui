import 'package:flutter/material.dart';

class QuickLinks extends StatefulWidget {
  const QuickLinks({Key? key}) : super(key: key);

  @override
  State<QuickLinks> createState() => QuickLinksState();
}

class QuickLinksState extends State<QuickLinks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           centerTitle: true,
          title: Text("Quick Links"),
        ),
        body: Center(
          child: Text(
            "Quick Links",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
