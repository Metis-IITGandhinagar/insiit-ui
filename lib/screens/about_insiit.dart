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
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'InsIIT App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'The official students app for IIT Gandhinagar.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            FilledButton.icon(
              icon: Icon(Icons.control_point_rounded),
              onPressed: () {
                // Handle Contribution button tap
                // You can navigate to the contribution page or any relevant link
              },
              label: Text('Contribute to the Project'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle Metis (Developer) Page button tap
                // You can navigate to the Metis (Developer) page or any relevant link
              },
              child: Text('Metis IITGN'),
            ),
            SizedBox(height: 16),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              '© 2024 Metis, IITGN',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
        );
  }
}