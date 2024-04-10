// import 'package:awesome_notifications/awesome_notifications.dart';
// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insiit/widgets/maps.dart';
import 'package:insiit/widgets/more.dart';
import '../services/messaging_service.dart';
import '../widgets/home.dart';
import '../widgets/mess.dart';
import '../widgets/bus.dart';
import './qr.dart';
import './notification.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _messagingService = MessagingService();

  // void initState() {
  //   AwesomeNotifications().isNotificationAllowed().then((isAllowed){
  //     if(!isAllowed){
  //       AwesomeNotifications().requestPermissionToSendNotifications();
  //     }

  //   });
  //   super.initState();
  // }
  // triggerNotification(){
  //   AwesomeNotifications().createNotification(content: NotificationContent(id: 1, channelKey: 'basic_channel', title: "InsIIT Notification Test", body: "This is a test notification"));
  // }
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

  @override
  void initState() {
    super.initState();
    _messagingService
        .init(context); // Initialize MessagingService to handle notifications
  }
}
