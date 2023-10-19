import 'package:flutter/material.dart';
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
                height: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 2 -
                          32, // minus 32 due to the margin
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(16.0),

                      decoration: const BoxDecoration(
                        color:
                            Color(0xFFE4D7FF), // background color of the cards
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // posion the everything to the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_bus_filled_outlined,
                            color: Color(0xFF5B33AC),
                          ),
                          Text("Bus Schedule",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Color(0xFF5B33AC),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 2 -
                          32, // minus 32 due to the margin
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color:
                            Color(0xFFFFD8C4), // background color of the cards
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.restaurant_menu_outlined,
                              color: Color.fromARGB(255, 127, 57, 0)),
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
                  ],
                ),
              ),
              Container(
                height: 200,
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 2 -
                          32, // minus 32 due to the margin
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color:
                            Color(0xFFD7F1FF), // background color of the cards
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
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
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width / 2 -
                          32, // minus 32 due to the margin
                      margin: EdgeInsets.all(16.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color:
                            Color(0xFFFFF7B3), // background color of the cards
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.contact_emergency_outlined,
                              color: Color.fromARGB(255, 141, 130, 25)),
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
                  ],
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  width: double.infinity,
                  color: Colors.white,
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
                                  Navigator.of(context).push(MaterialPageRoute(
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
