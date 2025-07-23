// import 'package:awesome_notifications/awesome_notifications.dart';
// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insiit/widgets/maps.dart';
import 'package:insiit/widgets/more.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/messaging_service.dart';
import '../widgets/home.dart';
import '../widgets/mess.dart';
import '../widgets/bus.dart';
import './qr.dart';
import './notification.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import '../widgets/outlet_explore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _messagingService = MessagingService();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => QRDisplay())),
          ),
          const SizedBox(
            width: 0,
          ),
          IconButton(
              icon: const Icon(Icons.logout_sharp),
              onPressed: () async {
                await GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
              }),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const HomePage(),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: OutletExplore(),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: BusPage(),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const MorePage(),
        )
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.fastfood_outlined),
            selectedIcon: Icon(Icons.fastfood),
            label: 'Outlets',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_bus_filled_outlined),
            selectedIcon: Icon(Icons.directions_bus_filled),
            label: 'Buses',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz_outlined),
            selectedIcon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _messagingService
        .init(context); // Initialize MessagingService to handle notifications
  }
}
