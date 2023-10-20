import 'package:flutter/material.dart';

class RepresentativesPage extends StatefulWidget {
  const RepresentativesPage({Key? key}) : super(key: key);

  @override
  State<RepresentativesPage> createState() => RepresentativesPageState();
}

class RepresentativesPageState extends State<RepresentativesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            "Representatives",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
