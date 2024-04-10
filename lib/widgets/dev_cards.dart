import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperCard extends StatelessWidget {
  final String phoneNumber;
  final String GithubURL;
  final String name;
  final String role;
  final String email;
  final String imageUrl;

  const DeveloperCard(
      {required this.phoneNumber,
      required this.GithubURL,
      required this.name,
      required this.role,
      required this.email,
      required this.imageUrl,
      Key? key})
      : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void _sendEmail() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'From InsIIT App: ',
        'body': "Dear $name",
      },
    );
    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: Image.network(imageUrl),
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(role),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: const FaIcon(FontAwesomeIcons.github),
                    onTap: () {
                      final Uri url = Uri.parse(GithubURL);
                      _launchInBrowser(url);
                    },
                  ),
                  GestureDetector(
                    child: const Icon(Icons.mail_outline_rounded),
                    onTap: () {
                      _sendEmail();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
