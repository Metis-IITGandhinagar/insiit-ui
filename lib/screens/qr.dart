import 'package:flutter/material.dart';

class QRDisplay extends StatefulWidget {
  const QRDisplay({Key? key}) : super(key: key);

  @override
  State<QRDisplay> createState() => QRDisplayState();
}

class QRDisplayState extends State<QRDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text("QR Code of your Mess!!",
          style: TextStyle(fontSize: 30,
          fontWeight: FontWeight.w600),
          ),
        ));
  }
}
