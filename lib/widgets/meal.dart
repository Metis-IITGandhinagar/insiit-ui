import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/meal.dart';

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal});

  final Meal meal;

  String capitalizeWords(String input) {
    if (input.isEmpty) {
      return input;
    }

    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }

    return words.join(' ');
  }


  getOutletName(int outletid) {
    switch (outletid) {
      case 1:
        return "VS Fastfood";
      case 2:
        return "Dawat Foods";
      case 3:
        return "Go Insta Cafe";
      // Add more cases for additional outlets
      default:
        return "Unknown Outlet";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.6,
            color: Theme.of(context).colorScheme.outline
          ),
          borderRadius: BorderRadius.circular(15)),
      

      // padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: ListTile(
        title: Text(
          capitalizeWords(meal.name ?? 'Meal Not Available')
          ,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        
        subtitle:
        Row(
          children: [
            
            Text(
              getOutletName(meal.outletid),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
              SizedBox(
              height: 10,
            )
          ],
        
        ),
         
        trailing: Text(
          "Rs. ${meal.price}",
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );

    //     Text(
    //       "Rs. ${meal.price}",
    //       style: const TextStyle(fontSize: 14),
    //     ),
    //     Text(
    // getOutletName(meal.outletid),
    //       style: const TextStyle(
    //           fontSize: 16, fontWeight: FontWeight.w300),
    //     ),

    // );
    // );

    // );

    // );
  }
}