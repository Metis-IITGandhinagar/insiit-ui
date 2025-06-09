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
            "Name": "Siddharth Sachin Doshi",
            "Contacts": {
                "Mobile": "8208710144",
                "Email": "siddharth.doshi@iitgn.ac.in"
            }
        },
        {
            "Position": "Convener, SS",
            "Name": "Shambhavi Agarwal",
            "Contacts": {
                "Mobile": "9827948651",
                "Email": "shambhavi.agrawal@iitgn.ac.in"
            }
        },
       
        {
            "Position": "Academic Secretary",
            "Name": "Shrishti Mishra",
            "Contacts": {
                "Mobile": "9263870017",
                "Email": "shrishti.mishra@iitgn.ac.in"
            }
        },
        {
            "Position": "Cultural Secretary",
            "Name": "Jovit Jayan",
            "Contacts": {
                "Mobile": "9400907585",
                "Email": "jovit.jayan@iitgn.ac.in"
            }
        },
        {
            "Position": "Technical Secretary",
            "Name": "Chandrabhan Patel",
            "Contacts": {
                "Mobile": "6376471802",
                "Email": "chandrabhan.patel@iitgn.ac.in"
            }
        },
        {
            "Position": "IR&P Secretary",
            "Name": "Rupak Banerjee",
            "Contacts": {
                "Mobile": "9007669974",
                "Email": "rupak.banerjee@iitgn.ac.in"
            }
        },
        {
            "Position": "PDC Secretary",
            "Name": "Mumuksh Anilkumar Jain",
            "Contacts": {
                "Mobile": "8459610057",
                "Email": "mumuksh.jain@iitgn.ac.in"
            }
        },
        {
            "Position": "Sports Secretary",
            "Name": "Keshav Sobania",
            "Contacts": {
                "Mobile": "7240638176",
                "Email": "keshav.sobania@iitgn.ac.in"
            }
        },
        {
            "Position": "Welfare Secretary",
            "Name": "Sridhar Singh Thakur",
            "Contacts": {
                "Mobile": "6362578897",
                "Email": "sridharsingh.thakur@iitgn.ac.in"
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
                  Text("$name", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
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
