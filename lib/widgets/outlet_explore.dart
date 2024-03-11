import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/meal.dart';
import '../widgets/meal.dart';

class OutletExplore extends StatefulWidget {
  const OutletExplore({super.key});

  @override
  State<OutletExplore> createState() => _OutletExploreState();
}

class _OutletExploreState extends State<OutletExplore> {
  List<Meal> meals = [];

// Get the iems on screen load
  @override
  void initState() {
    super.initState();
    fetchMeal();
  }

// The item list is updated in meals list
  Future<void> fetchMeal() async {
    final response = await http.get(
        Uri.parse('https://insiit-api.onrender.com/food-outlet_menu_food-item'),
        headers: {'x-api-key': 'D4tuaQYa1m2pqpILHOND4KSauRFMvbaU'});
        final outletFoods = json.decode(response.body);
    print(outletFoods['food_items']);

    if (response.statusCode == 200) {
      final List<dynamic> data = outletFoods['food_items'];
      final items = data
          .map((item) => Meal(
                id: item['id'],
                name: item['name'],
                price: item['price'],
                outletid: item['outlet_id'],
                // description: item['description'],
                // rating: item['rating'],
                // size: item['size'],
                // cal: item['cal'],
                // image: item['image'],
              ))
          .toList();

      setState(() {
        meals = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Column(
    
      children: [

        SizedBox(height: 30,),
        LinearProgressIndicator(),
         SizedBox(
        height: 30,
      ),
        Text("Getting Munchies for you..."),]
    );

    if (meals.isNotEmpty) {
      content = SizedBox(
        
        height: 350,
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealCard(
            meal: meals[index],
          ),
        ),
      );
    }
    return 
    Column(children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 200,
            width: double.infinity,
            // color: const Color(0xFFF6FFD3),
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  // "Order Food Online",
                  "Explore Outlets",
                  style: TextStyle(
                    // color: Color(0xFF000000),
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
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
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
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
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 0.6,
                        color: Theme.of(context).colorScheme.outline),
                    borderRadius: BorderRadius.circular(100)),
                splashColor: Colors.transparent,
                hoverElevation: 0,
                focusColor: Colors.transparent,
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                onPressed: () => {},
                child: Padding(
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
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            fontSize: 15,
                            fontWeight: FontWeight.w300),
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
      
    ]);
  }
}