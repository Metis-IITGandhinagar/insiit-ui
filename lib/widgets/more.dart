import 'package:flutter/material.dart';
import 'package:insiit/screens/about_insiit.dart';
import 'package:insiit/screens/imp_contacts.dart';
import 'package:insiit/screens/quick_links.dart';
import 'package:insiit/screens/representatives.dart';
import 'package:insiit/screens/team.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset("assets/more.png",
                   height: 200,
                    scale: 2.5,
                  )

                ],
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width:  MediaQuery.of(context).size.width - 50,
              child:  OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImportantContacts()),
                    );
                  },
                 child: Text("Important Contacts"),
                ),
            ),
             
          ],
        ),
         SizedBox(
            height: 20,
          ),
         Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DevelopersPage()),
                    );
                  },
                  child: Text("Team InsIIT"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuickLinks()),
                    );
                  },
                  child: Text("Quick Links"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RepresentativesPage()),
                    );
                  },
                  child: Text("Know You Representatives"),
                ),
              ),
            ],
          ), 
          SizedBox(
            height: 20,
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InsIITAbout()),
                    );
                  },
                  child: Text("About InsIIT"),
                ),
              ),
            ],
          )
        ],
      ),

    );
  }
}
