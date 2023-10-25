import 'package:flutter/material.dart';

import '../database/outlet.dart';
import '../models/meal.dart';
import '../widgets/meal.dart';

class OutletScreen extends StatefulWidget {
  const OutletScreen({super.key});

  @override
  State<OutletScreen> createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  List<Meal> meals = dummyMeals;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("Sorry but no items to show"),
    );

    if (meals.isNotEmpty) {
      content = Container(
        height: 450,
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealCard(
            meal: meals[index],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_checkout),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
        title: const Text(
          "Outlets",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Column(children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 200,
              width: double.infinity,
              color: const Color(0xFFF6FFD3),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Order Food Online",
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Feeling Hungry? You have come to the right place. Explore and enjoy delicious foods here",
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 50,
              bottom: -20,
              child: Container(
                color: Color(0xFF),
                width: 300,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFFFFFBFE),
                  onPressed: () => {},
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Search Dishes",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        content,
      ]),
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
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.dining_outlined),
            selectedIcon: Icon(Icons.dining),
            label: 'All Outlets',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_bus_filled_outlined),
            selectedIcon: Icon(Icons.receipt),
            label: 'Past Orders',
          ),
        ],
      ),
    );
  }
}
