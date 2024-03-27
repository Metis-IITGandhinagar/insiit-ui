import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/outlet.dart';
// import './outlet.dart';

class OutletAll extends StatefulWidget {
  const OutletAll({super.key});

  @override
  State<OutletAll> createState() => _OutletAllState();
}

class _OutletAllState extends State<OutletAll> {
  late Future<List<Outlet>> futureOutlets;

  @override
  void initState() {
    super.initState();
    futureOutlets = fetchOutlets();
  }

  Future<List<Outlet>> fetchOutlets() async {
    final response = await http.get(
        Uri.parse('https://insiit-api.onrender.com/food-outlet'),
        headers: {'x-api-key': 'D4tuaQYa1m2pqpILHOND4KSauRFMvbaU'});

    if (response.statusCode == 200) {
      final List<dynamic> outletData = json.decode(response.body)['outlets'];
      return outletData.map((item) => Outlet.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load outlets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Outlet>>(
        future: futureOutlets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                // backgroundColor: Theme.of(context).colorScheme.secondaryContainer,

              )
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final outlets = snapshot.data;

            return ListView.builder(
                itemCount: outlets?.length,
                itemBuilder: (context, index) {
                  return Card(
                    // elevation: 0,
                    // color: Theme.of(context).colorScheme.surfaceVariant,
                    margin: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                        title: Text(
                          outlets![index].name!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined),
                                SizedBox(width: 10),
                                Text(
                                  outlets![index].landmark!,
                                  style: const TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.access_time_rounded),
                                SizedBox(width: 10),
                                Text(
                                  "${outlets[index].openTime} - ${outlets[index].closeTime}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: Column(
                         children: [
                          InkWell(
                            
                            child:  Icon(Icons.menu_book_outlined, size: 40),
                            onTap: () {
                              
                            },

                          )
                          // Icon(Icons.menu_book_outlined, size: 40,),
                          // Text("Menu")
                         ],
                        ),
                        
                        ),
                    // Column(
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 20, bottom: 20),
                    //           child: Column(
                    //             children: [
                    //               Text(
                    //                outlets![index].name!,
                    //                 style: const TextStyle(
                    //                     fontSize: 20, fontWeight: FontWeight.w700),
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   const Icon(Icons.location_on_outlined),
                    //                   Text(
                    //                    outlets![index].landmark!,
                    //                     style: const TextStyle(fontSize: 14),
                    //                   )
                    //                 ],
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   const Icon(Icons.timer),
                    //                   Text(
                    //                     "${outlets[index].openTime} - ${outlets[index].closeTime}",
                    //                     style: const TextStyle(fontSize: 14),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           width: 20,
                    //           child: Image(image: AssetImage(outlets[index].image)),
                    //         ),
                    //       ],
                    //     ),
                    //     Container(
                    //       color: Colors.green[300],
                    //       child: InkWell(
                    //         child: const Text('Check the menu'),
                    //         onTap: () {},
                    //       ),
                    //     )
                    //   ],
                    // ),
                  );
                  //   ListTile(
                  //     title: Text(outlets![index].name!),
                  //     subtitle: Text(outlets![index].landmark!),
                  //   );
                  // },
                });
          }
        },
      ),
    );
//   List<Outlet> outlets = [];
//     List<Map<String, dynamic>> data = [];

// // Get the iems on screen load via GET reuqest
//   @override
//   void initState() {
//     super.initState();
//     fetchOutlet();
//   }

//   // The item list is updated in meals list
//   Future<void> fetchOutlet() async {
//     final response =
//         await http
//         .get(Uri.parse('https://insiit-api.onrender.com/food-outlet'), headers: {
//       'x-api-key': 'D4tuaQYa1m2pqpILHOND4KSauRFMvbaU'
//     });
//     print(response.body);

//     if (response.statusCode == 200) {
//       setState(() {
//         data.clear();
//         List items = jsonDecode(response.body) as List;
//         for (Map<String, dynamic> item in items) {
//           data.add(item);
//         }
//       });

//       // final List<dynamic> data = json.decode(response.body);
//       // final items = data
//       //     .map((item) => Outlet(
//       //           id: item['id'],
//       //           name: item['name'],
//       //           location: item['location'],
//       //           landmark: item['landmark'],
//       //           open: item['open'],
//       //           close: item['close'],
//       //           rating: item['rating'],
//       //           menu: item['menu'],
//       //           image: item['image'],
//       //         ))
//       //     .toList();
//       //     print(response.body);
//       //    setState(() {
//       //   outlets = items;
//       // });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget content = const Center(
//       child: Text("Sorry but no items to show"),
//     );

//     if (outlets.isNotEmpty) {
//       content = Container(
//         height: 450,
//         child: ListView.builder(
//           itemCount: outlets.length,
//           itemBuilder: (ctx, index) => OutletCard(
//             outlet: outlets[index],
//           ),
//         ),
//       );
//     }

//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: content,
    // );
  }
}
// }