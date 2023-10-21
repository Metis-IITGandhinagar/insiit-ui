import 'package:flutter/material.dart';
import 'package:insiit/screens/about_insiit.dart';
import 'package:insiit/screens/imp_contacts.dart';
import 'package:insiit/screens/post.dart';
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
        Card(
                  surfaceTintColor: Colors.white,
                  color: Color(0xFFD2DAFF),
                  margin: EdgeInsets.all(16.0),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    splashColor: Color(0x85839ED8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RepresentativesPage()),
                      );
                    },
                    child: SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 2 -
                          32, // minus 32 due to the margin

                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         
                          Text(
                            "Tinkerers' Lab",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 74, 86, 137),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),

                  Card(
                  surfaceTintColor: Colors.white,
                  color: Color(0xFFFFDFDF),
                  margin: EdgeInsets.all(16.0),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    splashColor: Color.fromARGB(92, 234, 119, 188),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RepresentativesPage()),
                      );
                    },
                    child: SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 2 -
                          32, // minus 32 due to the margin

                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                       
                          Text(
                            "Classroom Booking",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF6B3131),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
       ],
          ),
          SizedBox(
            height: 50,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
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
               SizedBox(
                height: 50,
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
              SizedBox(
                height: 50,
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
              SizedBox(
                height: 50,
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
             SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width - 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostPage()),
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
