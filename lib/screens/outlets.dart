
import 'package:flutter/material.dart';

import '../widgets/outlet_explore.dart';
import '../widgets/outlets.dart';
import '../widgets/outlet_order.dart';

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
        backgroundColor:Theme.of(context).colorScheme.secondaryContainer,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.shopping_cart_checkout),
        //     color: Colors.black,
        //     onPressed: () {},
        //   ),
        // ], do not delete
        title: const Text(
          "Outlets",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: <Widget>[
        Container(
        
          alignment: Alignment.center,
          child: OutletExplore(),
        ),
        Container(
        
          alignment: Alignment.center,
          child: const OutletAll(),
        ),
        Container(
        
          alignment: Alignment.center,
          child: const OutletsOrder(),
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
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.dining_outlined),
            selectedIcon: Icon(Icons.dining),
            label: 'All Outlets',
          ),
          // NavigationDestination(
          //   icon: Icon(Icons.receipt_outlined),
          //   selectedIcon: Icon(Icons.receipt),
          //   label: 'Past Orders',
          // ),
        ],
      ),
    );
  }
}