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
          title: const Text("Quick Links"),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: Colors.blue),
              title: const Text("Maintenance Portal"),
              subtitle: const Text("For all maintenance requests, use the online portal\nLink: http://maintenance.iitgn.ac.in"),
              onTap: () {
                // Open the maintenance portal in a web browser or navigate to a web page.
              },
            ),
            const ListTile(
              leading: Icon(Icons.security_outlined, color: Colors.red),
              title: Text("Campus Security (24x7)"),
              // subtitle: Text("Security supervisor hotline: 7567935473 (available 24x7)"),
            ),
            Container(
              child:
              const Row(children: [
                Padding(padding: EdgeInsets.all(10)),
                Text("Security Advisor hot line: 7567935473 (24x7)"),
              ],)
            )
            // ListTile(
            //   leading: Icon(Icons.person, color: Colors.green),
            //   title: Text("Security supervisor"),
            //   subtitle: Text("Manubhai Chaudhari | Amrut Rathod | Suresh Singh"),
            // ),
            // ListTile(
            //   leading: Icon(Icons.person, color: Colors.green),
            //   title: Text("Security officer"),
            //   subtitle: Text("Sumit Kumar"),
            // ),
            // ListTile(
            //   leading: Icon(Icons.phone, color: Colors.blue),
            //   title: Text("Contact"),
            //   subtitle: Text("8690971431"),
            // ),
          ],
        ),
        );
  }
}
