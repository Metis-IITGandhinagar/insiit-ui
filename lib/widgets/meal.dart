// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../models/meal.dart';

// class MealCard extends StatelessWidget {
//   const MealCard({super.key, required this.meal});

//   final Meal meal;

//   String capitalizeWords(String input) {
//     if (input.isEmpty) {
//       return input;
//     }

//     List<String> words = input.split(' ');

//     for (int i = 0; i < words.length; i++) {
//       if (words[i].isNotEmpty) {
//         words[i] =
//             words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
//       }
//     }

//     return words.join(' ');
//   }


//   getOutletName(int outletid) {
//     switch (outletid) {
//       case 1:
//         return "VS Fastfood";
//       case 2:
//         return "Dawat Foods";
//       case 3:
//         return "Go Insta Cafe";
//       // Add more cases for additional outlets
//       default:
//         return "Unknown Outlet";
//     }

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//           side: BorderSide(
//             width: 0.6,
//             color: Theme.of(context).colorScheme.outline
//           ),
//           borderRadius: BorderRadius.circular(15)),
      

//       // padding: const EdgeInsets.only(top: 20, bottom: 20),
//       child: ListTile(
//         title: Text(
//           capitalizeWords(meal.name ?? 'Meal Not Available')
//           ,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//         ),
        
//         subtitle:
//         Row(
//           children: [
            
//             Text(
//               getOutletName(meal.outletid),
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
//             ),
//               SizedBox(
//               height: 10,
//             )
//           ],
        
//         ),
         
//         trailing: Text(
//           "Rs. ${meal.price}",
//           style: const TextStyle(fontSize: 14),
//         ),
//       ),
//     );

   
//   }
// }

import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealWidget extends StatelessWidget {
  final Meal meal;

  MealWidget({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
       
        title: Text(
          meal.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 4),
            Text(
              '\$${meal.price?.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Handle onTap event here
        },
      ),
    );
  }
}
