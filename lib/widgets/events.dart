import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/events.dart';
import 'dart:async';

class EventWidget extends StatefulWidget {
  const EventWidget({super.key});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {

  Future<List<Event>> postsFuture = getPosts();

  static Future<List<Event>> getPosts() async {
    var url = Uri.parse("https://usableordinaryinformationtechnology--kumaranmol2.repl.co/events");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    print(response.body);
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
       body: Center(
        child: FutureBuilder<List<Event>>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              print(posts);
              return buildPosts(posts);
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),

    );
  }
}

  Widget buildPosts(List<Event> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          color: Color.fromARGB(255, 238, 235, 255),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          // child: Row(
          //   children: [
          //     SizedBox(width: 10),
          //     Expanded(flex: 3, child: Text(post.BusName!)),
          //   ],
          // ),
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.event_outlined),
                title: Text(post.name!),
                subtitle: Text("${post.date}" ),
            
           
              )
            ],
          ),
        );
      },
    );
  }

