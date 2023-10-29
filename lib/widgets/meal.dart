import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return 
    Card(
      color: Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
      side: BorderSide(
        color: Colors.blueGrey,
        width: 0.8
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              children: [
                Text(
                  
                  meal.title,
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    const Icon(Icons.star_border_outlined),
                    Text(
                      "${meal.reviews}",
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Text(
                  "Rs. ${meal.cost}",
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  meal.outlet,
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
            child: Image(image: AssetImage(meal.imageUrl)),
          ),
        ],
      ),
    );
  }
}
