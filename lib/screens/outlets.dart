import 'package:flutter/material.dart';

import '../widgets/outlet_explore.dart';
import '../widgets/outlets.dart';
import '../widgets/cart_screen.dart';
import 'package:badges/badges.dart' as badges;

class OutletScreen extends StatefulWidget {
  const OutletScreen({super.key});

  @override
  State<OutletScreen> createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Outlets",
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout_sharp), onPressed: () async {}),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: OutletExplore(),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: CartScreen(),
        ),
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
            icon: Icon(Icons.fastfood_outlined),
            selectedIcon: Icon(Icons.fastfood),
            label: 'All Outlets',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
      // Container(
      //   alignment: Alignment.center,
      //   child: ,
      // ),
    );
  }
}
