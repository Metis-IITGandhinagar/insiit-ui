import 'package:flutter/material.dart';

class ImportantContacts extends StatefulWidget {
  const ImportantContacts({Key? key}) : super(key: key);

  @override
  State<ImportantContacts> createState() => ImportantContactsState();
}

class ImportantContactsState extends State<ImportantContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Important Contacts"),
        ),
        body: Center(
          child: Text(
            "Important Contacts",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
