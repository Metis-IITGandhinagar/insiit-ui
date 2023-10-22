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
          title: Text("InsIIT Developers"),
        ),
        body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          children: const [
            DeveloperCard(
                phoneNumber: "",
                GithubURL: "https://github.com/mayankgul",
                name: "Mayank Gulati",
                role: "",
                email: "mayank.gulati@iitgn.ac.in",
                imageUrl:
                    "https://media.licdn.com/dms/image/D5603AQGMxYt2jU_lhA/profile-displayphoto-shrink_800_800/0/1680005993701?e=1703721600&v=beta&t=WIBvRUPfb6JKhXtt_LxEPhpaXq79UPwAlIVRXO011s8"),
            DeveloperCard(
                phoneNumber: "",
                GithubURL:
                    "https://github.com/AshStorm17",
                name: "Aashmun Gupta",
                role: "",
                email: "aashmun.gupta@iitgn.ac.in",
                imageUrl:
                    "https://media.licdn.com/dms/image/C5603AQFzPumH4AcueA/profile-displayphoto-shrink_800_800/0/1602848541859?e=1697673600&v=beta&t=zdk-JHO3svMVgo7dQyfAr5iE3lgEt9-a-Rd52x1-at0"),
          DeveloperCard(
                  phoneNumber: "",
                  GithubURL: "https://github.com/anmolkumr",
                  name: "Anmol Kumar",
                  role: "",
                  email: "kumaranmol@iitgn.ac.in",
                  imageUrl:
                      "https://media.licdn.com/dms/image/D5603AQGH7Y4vaPzLNA/profile-displayphoto-shrink_800_800/0/1677745140471?e=1703721600&v=beta&t=ZfU3lJjCZgGny5BOixhqPMBoyUopDTBYJ38eGRHLCf4"),
          
          
          
          ],
        ),
            ));
  }
}
