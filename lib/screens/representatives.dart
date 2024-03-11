import 'package:flutter/material.dart';
import 'dart:convert';

class RepresentativesPage extends StatefulWidget {
  const RepresentativesPage({super.key});

  @override
  _RepresentativesPageState createState() => _RepresentativesPageState();
}

class _RepresentativesPageState extends State<RepresentativesPage> {
  final String jsonPORData = '''
  {
    "StudentCouncilBody": [
       {
        "Position": "Convener Student Senate",
        "Name": "Amaan Ansari",
        "Contacts": {
          "Mobile": "987-654-3210",
          "Email": "jane.smith@example.com"
        }
      },
      {
        "Position": "General Secretary",
        "Name": "Abhishek Mungekar",
        "Contacts": {
          "Mobile": "123-456-7890",
          "Email": "john.doe@example.com"
        }
      },
      {
        "Position": "Academic Secretary",
        "Name": "Reuben Shibu Devanesan",
        "Contacts": {
          "Mobile": "987-654-3210",
          "Email": "jane.smith@example.com"
        }
      },
      {
        "Position": "Cultural Secretary",
        "Name": "Varad Sardeshpande",
        "Contacts": {
          "Mobile": "987-654-3210",
          "Email": "jane.smith@example.com"
        }
      },
      {
        "Position": "IR&P Secretary",
        "Name": "Bhavesh Jain",
        "Contacts": {
          "Mobile": "987-654-3210",
          "Email": "jane.smith@example.com"
        }
      },
      {
        "Position": "PDC Secretary",
        "Name": "Dhairya Shah",
        "Contacts": {
          "Mobile": "987-654-3210",
          "Email": "jane.smith@example.com"
        }
      },
      {
        "Position": "Sports Secretary",
        "Name": "Aman Samria",
        "Contacts": {
          "Mobile": "987-654-3210",
          "Email": "jane.smith@example.com"
        }
      },
      {
        "Position": "Welfare Secretary",
        "Name": "Harshvardhan Vala",
        "Contacts": {
          "Mobile": "987-654-3210",
          "Email": "jane.smith@example.com"
        }
      },
      {
        "Position": "Technical Secretary",
        "Name": "Progyan Das",
        "Contacts": {
          "Mobile": "987-654-3210",
          "Email": "jane.smith@example.com"
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
              title: Text(position),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: $name"),
                  Text("Mobile: $mobile"),
                  Text("Email: $email"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
