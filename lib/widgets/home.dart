import 'package:flutter/material.dart';
import 'package:insiit/screens/representatives.dart';
import 'mess.dart';
import 'bus_standalone.dart';
import '../screens/complaints.dart';
import 'mess.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text("Hi, Anmol",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: const Text("Welcome Back!!",
                        style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Container(
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                        surfaceTintColor: Color(0xFFE4D7FF),
                        color: Color(0xFFE0D0FF),
                        margin: EdgeInsets.all(16.0),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          splashColor: Color.fromARGB(103, 159, 111, 255),
                          onTap: () {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BusPageStandalone()),
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
                                Icon(
                                  Icons.directions_bus_filled_outlined,
                                  color: Color(0xFF5B33AC),
                                ),
                                Text(
                                  "Bus Schedule",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF5B33AC),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Card(
                        surfaceTintColor: Colors.white,
                        color: Color(0xFFFFD8C4),
                        margin: EdgeInsets.all(16.0),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          splashColor: Color.fromARGB(123, 255, 166, 121),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MealsDisplayScreen()),
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
                                Icon(
                                  Icons.restaurant_menu_outlined,
                                  color: Color.fromARGB(255, 127, 57, 0),
                                ),
                                Text(
                                  "Outlets",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 127, 57, 0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),

                    // InkWell(
                    //   // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    //   //  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    //   //     builder: (_) => const OutletsPage())),
                    //   child:
                    //   Container(
                    //     //       height: 120,
                    //     width: MediaQuery.of(context).size.width / 2 -
                    //         32, // minus 32 due to the margin
                    //     margin: EdgeInsets.all(16.0),
                    //     padding: EdgeInsets.all(16.0),
                    //     decoration: BoxDecoration(
                    //       color: Color(
                    //           0xFFFFD8C4), // background color of the cards
                    //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    //     ),
                    //     child: const Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Icon(Icons.restaurant_menu_outlined,
                    //             color: Color.fromARGB(255, 127, 57, 0)),
                    //         Text(
                    //           "Outlets",
                    //           style: TextStyle(
                    //             fontSize: 15,
                    //             color: Color.fromARGB(255, 127, 57, 0),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: Row(
                  children: [
                    Card(
                        color: Color(0xFFD7F1FF),
                        margin: EdgeInsets.all(16.0),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          splashColor: Color.fromARGB(173, 194, 233, 255),
                          onTap: () {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ComplainsPage()),
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
                                Icon(Icons.pending_actions_outlined,
                                    color: Color(0xFF398AB7)),
                                Text(
                                  "Complaints",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF398AB7),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Card(
                        surfaceTintColor: Colors.white,
                        color: Color(0xFFFFF6A1),
                        margin: EdgeInsets.all(16.0),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          splashColor: Color.fromARGB(144, 224, 216, 146),
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
                                Icon(
                                  Icons.contact_emergency_outlined,
                                  color: Color.fromARGB(255, 141, 130, 25),
                                ),
                                Text(
                                  "Representatives",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 141, 130, 25),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MealsDisplayScreen()),
                  );
                },
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Text("What's in the Mess?",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const MealsDisplayScreen()));
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ])
                    // const ListTile(

                    //   leading: Icon(Icons.food_bank_outlined),
                    //   title: Text("What is in the Mess?"),
                    //   trailing: IconButton(onPressed: (), icon: icon)
                    // ),
                    ),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 14,
        ),
      ]),
    );
  }
}
