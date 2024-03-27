import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InsIITAbout extends StatelessWidget {
  const InsIITAbout({Key? key}) : super(key: key);

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
              'This is the official students application for the students of IIT Gandhinagar.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                _launchURL('https://github.com/Metis-IITGandhinagar/insiit-ui');
              },
              icon: Icon(Icons.control_point_rounded),
              label: Text('Contribute to the Project'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _launchURL('https://github.com/Metis-IITGandhinagar/');
              },
              child: Text('Visit Metis IITGN'),
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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
