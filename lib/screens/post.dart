// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/posts.dart';

// class PostPage extends StatefulWidget {
//   const PostPage({super.key});

//   @override
//   State<PostPage> createState() => _PostPageState();
// }

// class _PostPageState extends State<PostPage> {

//   Future<List<Post>> postsFuture = getPosts();

//   static Future<List<Post>> getPosts() async {
//     var url = Uri.parse("https://usableordinaryinformationtechnology--kumaranmol2.repl.co/buses?from=Kudasan&to=Palaj");
//     final response =
//         await http.get(url, headers: {"Content-Type": "application/json"});
//     final List body = json.decode(response.body);
//     return body.map((e) => Post.fromJson(e)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        body: Center(
//         child: FutureBuilder<List<Post>>(
//           future: postsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasData) {
//               final posts = snapshot.data!;
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

//   Widget buildPosts(List<Post> posts) {
//     return ListView.builder(
//       itemCount: posts.length,
//       itemBuilder: (context, index) {
//         final post = posts[index];
//         return Container(
//           color: Color.fromARGB(255, 250, 242, 255),
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
//                 title: Text(post.BusName!),
//                 subtitle: Text("Departure: ${post.DepartureTime}" ),
//                 trailing: Text("Via: ${post.Stops}"),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PostPage extends StatefulWidget {
   const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<String> towns = ['ANY'];
  List<Map<String, dynamic>> data = [];
  String src = 'ANY', des = 'ANY';

  void setSrc(String? t) {
    setState(() {
      src = t ?? towns[0];
    });
  }

  void setDes(String? t) {
    setState(() {
      des = t ?? towns[0];
    });
  }

  void fetchTowns() async {
    Response response = await get(Uri.parse('https://usableordinaryinformationtechnology--kumaranmol2.repl.co/towns'));
    List result = jsonDecode(response.body) as List;
    setState(() {
      towns.clear();
      towns.add('ANY');
      for (Map<String, dynamic> item in result) {
        String? townName = item['name'];
        if (townName != null) towns.add(townName);
      }
    });
  }

  void search() async {
    String url = 'https://usableordinaryinformationtechnology--kumaranmol2.repl.co/buses?from=${src}&to=${des}';
    Response response = await get(Uri.parse(url));
    print(response.body);
    setState(() {
      data.clear();
      List items = jsonDecode(response.body) as List;
      for (Map<String, dynamic> item in items) {
        data.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchTowns();
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('SOURCE'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton(
                        value: src,
                        items: towns.map((element) {
                          return DropdownMenuItem(
                              value: element, child: Text(element));
                        }).toList(),
                        onChanged: setSrc),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('DESTINATION'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton(
                        value: des,
                        items: towns.map((element) {
                          return DropdownMenuItem(
                              value: element, child: Text(element));
                        }).toList(),
                        onChanged: setDes),
                  ),
                ],
              ),
            ],
          ),
          TextButton.icon(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: search,
            label: const Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) => BusCard(data: data[i])),
          ),
        ],
      ),
    );
  }
}

class BusCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const BusCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[700], borderRadius: BorderRadius.circular(12)),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    Text(
                      data['Source']!,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  
                  ],
                ),
                const Text(
                  '→',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                   
                    Text(
                      data['Destination']!,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
             Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'Departure Time ' + data['DepartureTime'],
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
             const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(
                  Icons.directions,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                   'Via'+ data['Stops'].join(', '),
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(
                  Icons.directions_bus,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  data['BusName']!,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
