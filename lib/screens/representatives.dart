import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class RepresentativesPage extends StatefulWidget {
  const RepresentativesPage({Key? key}) : super(key: key);

  @override
  _RepresentativesPageState createState() => _RepresentativesPageState();
}

class _RepresentativesPageState extends State<RepresentativesPage> {
  final String jsonPORData = '''
  {
    "StudentCouncilBody": [
        
        {
            "Position": "General Secretary",
            "Name": "Yash Dilip Ahire",
            "Contacts": {
                "Mobile": "7219193716",
                "Email": "yashahire@iitgn.ac.in"
            }
        },
        {
            "Position": "Academic Secretary",
            "Name": "Aditya Gupte",
            "Contacts": {
                "Mobile": "9664488377",
                "Email": "adityaaditya@iitgn.ac.in"
            }
        },
        {
            "Position": "Cultural Secretary",
            "Name": "Abhishek Meena",
            "Contacts": {
                "Mobile": "7340360895",
                "Email": "meenaabhishek@iitgn.ac.in"
            }
        },
        {
            "Position": "IR&P Secretary",
            "Name": "Parth Deshpande",
            "Contacts": {
                "Mobile": "9527662004",
                "Email": "deshpandeparth@iitgn.ac.in"
            }
        },
        {
            "Position": "PDC Secretary",
            "Name": "Aaryan Darad",
            "Contacts": {
                "Mobile": "9998583773",
                "Email": "daradaaryan@iitgn.ac.in"
            }
        },
        {
            "Position": "Sports Secretary",
            "Name": "Adit Rambhia",
            "Contacts": {
                "Mobile": "8850270294",
                "Email": "rambhiaadit@iitgn.ac.in"
            }
        },
        {
            "Position": "Welfare Secretary",
            "Name": "Gaurav",
            "Contacts": {
                "Mobile": "7627068716",
                "Email": "mahendragaurav@iitgn.ac.in"
            }
        },
        {
            "Position": "Technical Secretary",
            "Name": "Naman Dharmani",
            "Contacts": {
                "Mobile": "8378009665",
                "Email": "dharmaninaman@iitgn.ac.in"
            }
        }
    ]
}

  ''';

  List<dynamic> studentCouncilData = [];

  @override
  void initState() {
    super.initState();
    studentCouncilData = json.decode(jsonPORData)["StudentCouncilBody"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Know your Representatives"),
      ),
      body: ListView.builder(
        itemCount: studentCouncilData.length,
        itemBuilder: (context, index) {
          final position = studentCouncilData[index]["Position"];
          final name = studentCouncilData[index]["Name"];
          final mobile = studentCouncilData[index]["Contacts"]["Mobile"];
          final email = studentCouncilData[index]["Contacts"]["Email"];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(position),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$name"),
                  Text("$mobile"),
                  Text("$email"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () => _launchPhoneCall(mobile),
                  ),
                  IconButton(
                    icon: Icon(Icons.email),
                    onPressed: () => _launchEmail(email),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// Function to launch phone call
  Future<void> _launchPhoneCall(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber'); // Convert phone number to Uri
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch phone call'),
        ),
      );
    }
  }

// Function to launch email composer
  Future<void> _launchEmail(String emailAddress) async {
    final url =
        Uri.parse('mailto:$emailAddress'); // Convert email address to Uri
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch email app'),
        ),
      );
    }
  }
}
