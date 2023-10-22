import 'package:flutter/material.dart';
import 'package:insiit/widgets/maps.dart';
import 'package:insiit/widgets/more.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            color: Colors.black,
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const QRDisplay())),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            color: Colors.black,
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationScreen())),
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
          child: const BusPage(),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const MapPage(),
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
            icon: Icon(Icons.directions_bus_filled_outlined),
            selectedIcon: Icon(Icons.directions_bus_filled),
            label: 'Bus',
          ),
           NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map_sharp),
            label: 'Campus Map',
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
}
