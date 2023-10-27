// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/events.dart';
// import 'dart:async';

// class EventWidget extends StatefulWidget {
//   const EventWidget({super.key});

//   @override
//   State<EventWidget> createState() => _EventWidgetState();
// }

// class _EventWidgetState extends State<EventWidget> {

//   Future<List<Event>> postsFuture = getPosts();

//   static Future<List<Event>> getPosts() async {
//     var url = Uri.parse("https://usableordinaryinformationtechnology--kumaranmol2.repl.co/events");
//     final response =
//         await http.get(url, headers: {"Content-Type": "application/json"});
//     print(response.body);
//     final List body = json.decode(response.body);
//     return body.map((e) => Event.fromJson(e)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Upcoming Events"),
//       ),
//        body: Center(
//         child: FutureBuilder<List<Event>>(
//           future: postsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasData) {
//               final posts = snapshot.data!;
//               print(posts);
//               return buildPosts(posts);
//             } else {
//               return const Text("No data available");
//             }
//           },
//         ),
//       ),

//     );
//   }
// }

//   Widget buildPosts(List<Event> posts) {
//     return ListView.builder(
//       itemCount: posts.length,
//       itemBuilder: (context, index) {
//         final post = posts[index];
//         return Container(
//           color: Color.fromARGB(255, 238, 235, 255),
//           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//           padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//           height: 100,
//           width: double.maxFinite,
//           // child: Row(
//           //   children: [
//           //     SizedBox(width: 10),
//           //     Expanded(flex: 3, child: Text(post.BusName!)),
//           //   ],
//           // ),
//           child: ListView(
//             children: [
//               ListTile(
//                 leading: Icon(Icons.event_outlined),
//                 title: Text(post.name!),
//                 subtitle: Text("${post.date}" ),
            
           
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/events.dart';
// import 'dart:async';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';


// class EventWidget extends StatefulWidget {
//   const EventWidget({super.key});

//   @override
//   State<EventWidget> createState() => _EventWidgetState();
// }

// class _EventWidgetState extends State<EventWidget> {
//  final controller = PageController(viewportFraction: 0.8, keepPage: true);
 
//   Future<List<Event>> postsFuture = getPosts();

//   static Future<List<Event>> getPosts() async {
//     var url = Uri.parse("https://usableordinaryinformationtechnology--kumaranmol2.repl.co/events");
//     final response =
//         await http.get(url, headers: {"Content-Type": "application/json"});
//     print(response.body);
//     final List body = json.decode(response.body);
//     return body.map((e) => Event.fromJson(e)).toList();
//   }


//   @override
//   Widget build(BuildContext context) {
//       final pages = List.generate(
//         6,
//         (index) => Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.grey.shade300,
//               ),
//               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               child: Container(
//                 height: 280,
//                 child: Center(
//                     child: Text(
//                   "Page $index",
//                   style: TextStyle(color: Colors.indigo),
//                 )),
//               ),
//             ));
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Upcoming Events"),
//       ),
//       body:
      
//       SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(height: 16),
//               SizedBox(
//                 height: 240,
//                 child: PageView.builder(
//                   controller: controller,
//                   // itemCount: pages.length,
//                   itemBuilder: (_, index) {
//                     return pages[index % pages.length];
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 24, bottom: 12),
//                 child: Text(
//                   'Worm',
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ),
//               SmoothPageIndicator(
//                 controller: controller,
//                 count: pages.length,
//                 effect: const WormEffect(
//                   dotHeight: 16,
//                   dotWidth: 16,
//                   type: WormType.thinUnderground,
//                 ),
//               ),
//               ]
//       ),
//         )
//       )
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/events.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({super.key});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  Future<List<Event>> postsFuture = getPosts();

  static Future<List<Event>> getPosts() async {
    var url = Uri.parse(
        "https://usableordinaryinformationtechnology--kumaranmol2.repl.co/events");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Event.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Upcoming Events"),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Event>>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              final events = snapshot.data;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 16),
                    SizedBox(
                      height: 240,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: events?.length, // Use the length of events
                        itemBuilder: (_, index) {
                          final event = events?[index];
                          return Container(
                            decoration: BoxDecoration(
                              // color: Colors.grey.shade300,
                              image: const DecorationImage(image: NetworkImage("https://picsum.photos/200/300"),
                              fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(16),
                              
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Container(
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                   begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                  colors: [
                                Colors.black.withOpacity(.1),
                                Colors.black.withOpacity(.7),])),
                              height: 280,
                              child: Center(
                                child: Text(
                                  event?.name ??
                                      'Events Not Available', // Display event name
                                  style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255),
                                      fontWeight:FontWeight.bold, fontSize: 20),
                                ),
                              ),
                              
                            ),
                         
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 12),
                      
                    ),
                    SmoothPageIndicator(
                      controller: controller,
                      count: events?.length ?? 0, // Use the length of events
                      effect: const WormEffect(
                        dotHeight: 6,
                        dotWidth: 10,
                        type: WormType.normal,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

