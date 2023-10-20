import 'package:flutter/material.dart';

class DevelopersPage extends StatefulWidget {
  const DevelopersPage({Key? key}) : super(key: key);

  @override
  State<DevelopersPage> createState() => DevelopersPageState();
}

class DevelopersPageState extends State<DevelopersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Developers"),
        ),
        body: ListView(
         children: [
          Row(
            children: [
              
            ],
          )
         ],
        ));
  }
}
