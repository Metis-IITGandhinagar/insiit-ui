import 'package:flutter/material.dart';

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
      body: Column(children: [
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
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 500,
          width: double.infinity,
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              Card(
                color: const Color.fromARGB(255, 131, 97, 189),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.directions_bus_filled),
                  title: Text("Bus Schedule"),
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 226, 140, 78),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.restaurant_menu),
                  title: Text("Outlets"),
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 122, 194, 220),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.mail_outline),
                  title: Text("Complaints"),
                ),
              ),
              Card(
                color: const Color.fromARGB(255, 247, 179, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.search),
                  title: Text("Search InsIIT"),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: const ListTile(
            leading: Icon(Icons.food_bank_outlined),
            title: Text("What is in the Mess?"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
