// // Please note this file is applicabke with onrender api only not the node js api

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'events_details.dart';
// import 'mess.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../screens/outlets.dart';
// import 'bus_standalone.dart';
// import 'events.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/events.dart';
// import 'dart:async';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// var name = FirebaseAuth.instance.currentUser!.displayName;

// var nameArray = name?.split(" ");

// class _HomePageState extends State<HomePage> {
//   Map<String, dynamic> weeklyMenu = {};
//   Widget buildMenu(String day, String mealType) {
//     if (weeklyMenu['menu'] != null &&
//         weeklyMenu['menu'][day] != null &&
//         weeklyMenu['menu'][day][mealType] != null) {
//       List<dynamic> meals = weeklyMenu['menu'][day][mealType];

//       if (meals != null && meals.isNotEmpty) {
//         return Row(children: [
//           Card(
//               elevation: 0,
//               surfaceTintColor: Color.fromARGB(255, 228, 230, 255),
//               color: Theme.of(context).colorScheme.secondaryContainer,
//               margin: const EdgeInsets.all(16.0),
//               child: InkWell(
//                 borderRadius: const BorderRadius.all(Radius.circular(16.0)),
//                 splashColor: const Color.fromARGB(103, 159, 111, 255),
//                 child: SizedBox(
//                   height: 220,
//                   width: MediaQuery.of(context).size.width -
//                       32, // minus 32 due to the margin

//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         '$mealType'.toUpperCase(),
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                           color: Theme.of(context)
//                               .colorScheme
//                               .onSecondaryContainer,
//                         ),
//                       ),
//                       for (var meal in meals)
//                         Text(
//                           meal['name'],
//                           style: TextStyle(
//                             color: Theme.of(context)
//                                 .colorScheme
//                                 .onPrimaryContainer,
//                           ),
//                         )
//                     ],
//                   ),
//                 ),
//               )),

//           // return Row(

//           //   crossAxisAlignment: CrossAxisAlignment.center,
//           //   children: [

//           //     Text(
//           //       '$mealType:'.toUpperCase(),
//           //       style: TextStyle(fontWeight: FontWeight.bold),
//           //     ),
//           //     for (var meal in meals)
//           //     Container(
//           //       margin: EdgeInsets.all(40),
//           //       child: Center(child: Text(meal['name']),),
//           //     ),

//           //     // ListTile(
//           //     //   title: Text(meal['name']),
//           //     //   subtitle: Text(meal['description']),
//           //     //   leading: CircleAvatar(
//           //     //     backgroundImage: NetworkImage(meal['image']),
//           //     //   ),
//           //     // ),

//           //   ],
//           // );
//         ]);
//       }
//     }

//     return Container(); // Return an empty container if there are no meals for the specified day and meal type
//   }

//   Future<void> fetchMenu() async {
//     final response = await http
//         .get(Uri.parse('https://insiit-api.onrender.com/mess/2/menu'));
//     final extractedData = json.decode(response.body);
//     print(extractedData);
//     setState(() {
//       weeklyMenu = extractedData;
//       print(weeklyMenu);
//     });

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('weeklyMenu', json.encode(extractedData));
//   }

//   Future<Map<String, dynamic>> loadMenuFromPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey('weeklyMenu')) {
//       return json.decode(prefs.getString('weeklyMenu')!);
//     } else {
//       return {};
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadMenuFromPrefs().then((data) {
//       if (data.isEmpty) {
//         fetchMenu();
//       } else {
//         setState(() {
//           weeklyMenu = data;
//         });
//       }
//     });
//   }

//   final controller = PageController(viewportFraction: 0.8, keepPage: true);

//   Future<List<Events>> postsFuture = getPosts();

//   static Future<List<Events>> getPosts() async {
//     var url = Uri.parse("http://10.7.39.171:3000/api/events");
//     final response =
//         await http.get(url, headers: {"Content-Type": "application/json"});
//     final List body = json.decode(response.body);
//     return body.map((e) => Events.fromJson(e)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const days = [
//       'monday',
//       'tuesday',
//       'wednesday',
//       'thursday',
//       'friday',
//       'saturday',
//       'sunday'
//     ];
//     String today() {
//       return DateFormat('EEEE').format(DateTime.now()).toLowerCase();
//     }

//     var todayname = today();
//     final TimeOfDay now = TimeOfDay.now();
//     print(now);
//     final pages = List.generate(
//       6,
//       (index) => Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: const Color.fromARGB(255, 233, 236, 255),
//         ),
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//         child: Container(
//           height: 180,
//           child: Center(
//               child: Text(
//             "Event $index",
//             style: TextStyle(
//               color: Theme.of(context).colorScheme.onSecondaryContainer,
//             ),
//           )),
//         ),
//       ),
//     );

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Hi, ${nameArray?[0]}',
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 25)),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     const Text("Welcome Back!!",
//                         style: TextStyle(fontSize: 15)),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // const SizedBox(
//           //   height: 10,
//           // ),

//           Row(children: [
//             Card(
//                 surfaceTintColor:
//                     Theme.of(context).colorScheme.secondaryContainer,
//                 color: Theme.of(context).colorScheme.secondaryContainer,
//                 margin: const EdgeInsets.all(16.0),
//                 child: InkWell(
//                   borderRadius: const BorderRadius.all(Radius.circular(16.0)),
//                   splashColor: const Color.fromARGB(103, 159, 111, 255),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const BusPageStandalone()),
//                     );
//                   },
//                   child: SizedBox(
//                     height: 120,
//                     width: MediaQuery.of(context).size.width / 2 -
//                         32, // minus 32 due to the margin

//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.directions_bus_filled_outlined,
//                           color: Theme.of(context)
//                               .colorScheme
//                               .onSecondaryContainer,
//                         ),
//                         Text(
//                           "Bus Schedule",
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Theme.of(context)
//                                 .colorScheme
//                                 .onSecondaryContainer,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )),
//             Card(
//                 surfaceTintColor: Colors.white,
//                 color: Theme.of(context).colorScheme.tertiaryContainer,
//                 margin: const EdgeInsets.all(16.0),
//                 child: InkWell(
//                   borderRadius: const BorderRadius.all(Radius.circular(16.0)),
//                   splashColor: const Color.fromARGB(123, 255, 166, 121),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const OutletScreen()),
//                     );
//                   },
//                   child: SizedBox(
//                     height: 120,
//                     width: MediaQuery.of(context).size.width / 2 -
//                         32, // minus 32 due to the margin

//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.restaurant_menu_outlined,
//                           color:
//                               Theme.of(context).colorScheme.onTertiaryContainer,
//                         ),
//                         Text(
//                           "Outlets",
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Theme.of(context)
//                                 .colorScheme
//                                 .onTertiaryContainer,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )),
//           ]),
//           InkWell(
//             borderRadius: const BorderRadius.all(Radius.circular(20.0)),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const EventWidget()),
//               );
//             },
//             child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 width: double.infinity,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(width: 10),
//                         Text("What's on the Campus?",
//                             style: TextStyle(fontSize: 18)),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (_) => const EventWidget()));
//                             },
//                             icon: const Icon(Icons.arrow_forward_ios))
//                       ],
//                     ),
//                   ],
//                 )
//                 // const ListTile(

//                 //   leading: Icon(Icons.food_bank_outlined),
//                 //   title: Text("What is in the Mess?"),
//                 //   trailing: IconButton(onPressed: (), icon: icon)
//                 // ),
//                 ),
//           ),
//           SafeArea(
//             child: FutureBuilder<List<Events>>(
//               future: postsFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text("Error: ${snapshot.error}"),
//                   );
//                 } else {
//                   final events = snapshot.data;

//                   return SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         const SizedBox(height: 16),
//                         SizedBox(
//                           height: 180,
//                           child: PageView.builder(
//                             controller: controller,
//                             itemCount:
//                                 events?.length, // Use the length of events
//                             itemBuilder: (_, index) {
//                               final event = events?[index];
//                               return InkWell(
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(16.0)),
//                                   splashColor:
//                                       const Color.fromARGB(103, 159, 111, 255),
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               EventDetailsPage(
//                                                   event: events?[index])),
//                                     );
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       // color: Colors.grey.shade300,
//                                       image: DecorationImage(
//                                           image:
//                                               NetworkImage("${event?.image}"),
//                                           fit: BoxFit.cover),
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     margin: const EdgeInsets.symmetric(
//                                         horizontal: 10, vertical: 4),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(16),
//                                           gradient: LinearGradient(
//                                               begin: Alignment.topCenter,
//                                               end: Alignment.bottomCenter,
//                                               colors: [
//                                                 Colors.black.withOpacity(0),
                                               
//                                                 Colors.black.withOpacity(.6),
//                                               ])),
//                                       height: 280,
//                                       child: Center(
//                                         child: Text(
//                                           event?.name ??
//                                               'Events Not Available', // Display event name
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 255, 255, 255),
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 18),
//                                         ),
//                                       ),
//                                     ),
//                                   ));
//                             },
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(top: 4, bottom: 12),
//                         ),
//                         SmoothPageIndicator(
//                           controller: controller,
//                           count:
//                               events?.length ?? 0, // Using the length of events
//                           effect: const WormEffect(
//                             dotHeight: 6,
//                             dotWidth: 6,
//                             type: WormType.normal,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),

//           InkWell(
//             borderRadius: const BorderRadius.all(Radius.circular(20.0)),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Menu()),
//               );
//             },
//             child: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 width: double.infinity,
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(width: 10),
//                           Text("What's in the Mess?",
//                               style: TextStyle(fontSize: 18)),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 Navigator.of(context).push(
//                                     MaterialPageRoute(builder: (_) => Menu()));
//                               },
//                               icon: const Icon(Icons.arrow_forward_ios))
//                         ],
//                       ),
//                     ])
//                 // const ListTile(

//                 //   leading: Icon(Icons.food_bank_outlined),
//                 //   title: Text("What is in the Mess?"),
//                 //   trailing: IconButton(onPressed: (), icon: icon)
//                 // ),
//                 ),
//           ),
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             if (now.hour < 11)
//               Row(
//                 children: [
//                   // SizedBox(height: 50),
//                   buildMenu(todayname, 'breakfast'),
//                 ],
//               )
//             else if (now.hour < 15)
//               Row(
//                 children: [
//                   // SizedBox(height: 50),
//                   buildMenu(todayname, 'lunch'),
//                 ],
//               )
//             else if (now.hour < 18)
//               Row(
//                 children: [
//                   // SizedBox(height: 50),
//                   buildMenu(todayname, 'snacks'),
//                 ],
//               )
//             else if (now.hour < 23)
//               Row(
//                 children: [
//                   // SizedBox(height: 50),
//                   buildMenu(todayname, 'dinner'),
//                 ],
//               )
//             else
//               Row(
//                 children: [
//                   // SizedBox(height: 50),
//                   buildMenu(todayname, 'breakfast'),
//                 ],
//               )
//           ]),
//           const SizedBox(
//             height: 90,
//           ),
//         ],
//       ),
//     );
//   }
// }
