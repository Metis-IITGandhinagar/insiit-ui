import 'package:flutter/material.dart';

import '../widgets/home.dart';
import '../widgets/mess.dart';
import '../widgets/bus.dart';
import './qr.dart';
import './notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            color: Colors.black,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const QRDisplay())),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            color: Colors.black,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationScreen())),
          ),
          const SizedBox(
            width: 20,
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
          child: const MessPage(),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const BusPage(),
        ),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(255, 251, 254, 1),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(127, 129, 98, 137),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_rounded),
            label: 'Mess',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_bus),
            label: 'Bus',
          ),
        ],
      ),
    );
  }
}
