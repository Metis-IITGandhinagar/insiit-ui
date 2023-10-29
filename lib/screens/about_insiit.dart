import 'package:flutter/material.dart';

class InsIITAbout extends StatefulWidget {
  const InsIITAbout({Key? key}) : super(key: key);

  @override
  State<InsIITAbout> createState() => InsIITAboutState();
}

class InsIITAboutState extends State<InsIITAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           centerTitle: true,
          title: const Text("About InsIIT"),
        ),
        body: const Center(
          child: Text(
            "About InsIIT",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
