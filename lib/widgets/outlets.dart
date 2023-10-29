import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/outlet.dart';
import './outlet.dart';

class OutletAll extends StatefulWidget {
  const OutletAll({super.key});

  @override
  State<OutletAll> createState() => _OutletAllState();
}

class _OutletAllState extends State<OutletAll> {
  List<Outlet> outlets = [];

// Get the iems on screen load via GET reuqest
  @override
  void initState() {
    super.initState();
    fetchOutlet();
  }

  // The item list is updated in meals list
  Future<void> fetchOutlet() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/food-outlet'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final items = data
          .map((item) => Outlet(
                id: item['id'],
                name: item['name'],
                location: item['location'],
                landmark: item['landmark'],
                open: item['open'],
                close: item['close'],
                rating: item['rating'],
                menu: item['menu'],
                image: item['image'],
              ))
          .toList();

      setState(() {
        outlets = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("Sorry but no items to show"),
    );

    if (outlets.isNotEmpty) {
      content = Container(
        height: 450,
        child: ListView.builder(
          itemCount: outlets.length,
          itemBuilder: (ctx, index) => OutletCard(
            outlet: outlets[index],
          ),
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: content,
    );
  }
}
