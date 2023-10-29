
import '../models/meal.dart';

// // Constants in Dart should be written in lowerCamelcase.
// const availableCategories = [
//   Category(
//     id: 'c1',
//     title: 'Italian',
//     color: Colors.purple,
//   ),
//   Category(
//     id: 'c2',
//     title: 'Quick & Easy',
//     color: Colors.red,
//   ),
//   Category(
//     id: 'c3',
//     title: 'Hamburgers',
//     color: Colors.orange,
//   ),
//   Category(
//     id: 'c4',
//     title: 'German',
//     color: Colors.amber,
//   ),
//   Category(
//     id: 'c5',
//     title: 'Light & Lovely',
//     color: Colors.blue,
//   ),
//   Category(
//     id: 'c6',
//     title: 'Exotic',
//     color: Colors.green,
//   ),
//   Category(
//     id: 'c7',
//     title: 'Breakfast',
//     color: Colors.lightBlue,
//   ),
//   Category(
//     id: 'c8',
//     title: 'Asian',
//     color: Colors.lightGreen,
//   ),
//   Category(
//     id: 'c9',
//     title: 'French',
//     color: Colors.pink,
//   ),
//   Category(
//     id: 'c10',
//     title: 'Summer',
//     color: Colors.teal,
//   ),
// ];

const dummyMeals = [
  Meal(
    id: 'm1',
    categories: [
      'c1',
      'c2',
    ],
    title: 'Italian Pizza',
    cost: 70,
    outlet: 'VS Fastfood',
    imageUrl: "assets/images/image2.png",
    isVeg: true,
    reviews: 4.0,
  ),
  Meal(
    id: 'm2',
    categories: [
      'c2',
    ],
    title: 'Cold Mocha',
    cost: 50,
    outlet: 'Go Insta',
    imageUrl: "assets/images/image2.png",
    isVeg: true,
    reviews: 4.3,
  ),
  Meal(
    id: 'm3',
    categories: [
      'c2',
      'c3',
    ],
    title: 'Vada Pav',
    cost: 40,
    outlet: 'VS Fastfood',
    imageUrl: "assets/images/image2.png",
    isVeg: true,
    reviews: 4.0,
  ),
  Meal(
    id: 'm4',
    categories: [
      'c4',
    ],
    title: 'Chilly Chicken',
    cost: 80,
    outlet: 'Just Chill',
    imageUrl: "assets/images/image2.png",
    isVeg: true,
    reviews: 4.0,
  ),
];
