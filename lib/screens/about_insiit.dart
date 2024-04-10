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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/Icon.png', // Replace with your actual logo path
              height: 100,
              width: 100,
            ),
            SizedBox(height: 16),
            Text(
              'InsIIT App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This is the official student application designed exclusively for the students of IIT Gandhinagar. It empowers you to stay connected, informed, and engaged with the institute community.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Contribute Button
                ElevatedButton.icon(
                  onPressed: () => _launchURL(
                      'https://github.com/Metis-IITGandhinagar/insiit-ui'),
                  icon: Icon(Icons.code),
                  label: Text('Contribute'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),

                // Visit Metis Button
                ElevatedButton(
                  onPressed: () =>
                      _launchURL('https://github.com/Metis-IITGandhinagar/'),
                  child: Text('Visit Metis IITGN'),
                  style: ElevatedButton.styleFrom(
                     backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              '© 2024 Metis, IITGN',
              style: TextStyle(fontSize: 14, color: Colors.grey),
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
