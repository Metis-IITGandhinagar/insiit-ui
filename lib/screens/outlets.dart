// This page is not being used currently, but it is kept for future use. may delete later.
import 'package:flutter/material.dart';

import '../widgets/outlet_explore.dart';
import '../widgets/outlets.dart';
// import '../widgets/cart_screen.dart';
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
      body: <Widget>[
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: OutletExplore(),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          // child: CartScreen(),
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
    
    );
  }
}
