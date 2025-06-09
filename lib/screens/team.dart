import 'package:flutter/material.dart';
import '../widgets/dev_cards.dart';

class DevelopersPage extends StatefulWidget {
  const DevelopersPage({Key? key}) : super(key: key);

  @override
  State<DevelopersPage> createState() => DevelopersPageState();
}

class DevelopersPageState extends State<DevelopersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("InsIIT Developers"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          children: [
            ExpansionTile(
              title: const Text('Developers'),
              initiallyExpanded: true, // Initially expanded
              children: [
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  children: const [
                    DeveloperCard(
                      phoneNumber: "",
                      GithubURL: "https://github.com/anmolkumr",
                      name: "Anmol Kumar",
                      role: "",
                      email: "kumaranmol@iitgn.ac.in",
                      imageUrl:
                          "https://raw.githubusercontent.com/anmolkumr/insiit-ui/master/assets/anmol-insiit.jpg",
                    ),
                    DeveloperCard(
                      phoneNumber: "",
                      GithubURL: "https://github.com/mayankgul",
                      name: "Mayank Gulati",
                      role: "",
                      email: "mayank.gulati@iitgn.ac.in",
                      imageUrl:
                          "https://raw.githubusercontent.com/anmolkumr/insiit-ui/master/assets/mayank-insiit.jpeg",
                    ),
                    
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ExpansionTile(
              title: const Text('Contributors'),
              initiallyExpanded: false, // Initially expanded
              children: [
                GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  children: const [
                    DeveloperCard(
                      phoneNumber: "",
                      GithubURL: "https://github.com/AshStorm17",
                      name: "Aashmun Gupta",
                      role: "",
                      email: "aashmun.gupta@iitgn.ac.in",
                      imageUrl:
                          "https://raw.githubusercontent.com/anmolkumr/insiit-ui/master/assets/aashmun-insiit.jpeg",
                    ),
                    DeveloperCard(
                      phoneNumber: "",
                      GithubURL: "https://github.com",
                      name: "Karan Gandhi",
                      role: "",
                      email: "@iitgn.ac.in",
                      imageUrl:
                          "https://raw.githubusercontent.com/anmolkumr/insiit-ui/master/assets/karan-insiit.jpeg",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
