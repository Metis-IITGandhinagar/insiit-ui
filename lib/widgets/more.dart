import 'package:flutter/material.dart';
import 'package:insiit/TLBooking/tl.dart';
import 'package:insiit/screens/about_insiit.dart';
import 'package:insiit/screens/complaints.dart';
import 'package:insiit/screens/foods.dart';
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
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        Card(
                  surfaceTintColor: Colors.white,
                  color: const Color(0xFFD2DAFF),
                  margin: const EdgeInsets.all(16.0),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    splashColor: const Color(0x85839ED8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TLBookingPage()),
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
                  color: const Color(0xFFFFDFDF),
                  margin: const EdgeInsets.all(16.0),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    splashColor: const Color.fromARGB(92, 234, 119, 188),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  const ComplainsPage()),
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
                            "Complaints",
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
          const SizedBox(
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
                 child: const Text("Medical Facility"),
                ),
            ),
             
          ],
        ),
         const SizedBox(
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
                  child: const Text("Team InsIIT"),
                ),
              ),
            ],
          ),
          const SizedBox(
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
                  child: const Text("Quick Links"),
                ),
              ),
            ],
          ),
          const SizedBox(
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
                          builder: (context) => RepresentativesPage()),
                    );
                  },
                  child: const Text("Know You Representatives"),
                ),
              ),
            ],
          ), 
          const SizedBox(
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
                          builder: (context) => const InsIITAbout()),
                    );
                  },
                  child: const Text("About InsIIT"),
                ),
              ),
            ],
          ),
            const SizedBox(
              height: 10,
            ),
          
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SizedBox(
              height: 40,
              child: Text(
                
                "v 1.1"
              ),
            )],
          )
        ],
      ),

    );
  }
}
