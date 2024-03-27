import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/outlet.dart';
import 'meal.dart';

class OutletExplore extends StatefulWidget {
  @override
  _OutletExploreState createState() => _OutletExploreState();
}

class _OutletExploreState extends State<OutletExplore> {
  late Future<List<Outlet>> futureOutlets;

  @override
  void initState() {
    super.initState();
    futureOutlets = fetchOutlets();
  }

  Future<List<Outlet>> fetchOutlets() async {
    final response =
        await http.get(Uri.parse('http://10.7.39.171:3000/api/outlets'));
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData.map((data) => Outlet.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch outlets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder<List<Outlet>>(
        future: futureOutlets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Outlet>? outlets = snapshot.data;
            return ListView.builder(
              itemCount: outlets!.length,
              itemBuilder: (context, index) {
                return OutletWidget(outlet: outlets[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          // By default, show a loading spinner
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class OutletWidget extends StatelessWidget {
  final Outlet outlet;

  OutletWidget({required this.outlet});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(outlet.name),
      subtitle: Text(outlet.location.latitude + ', ' + outlet.location.longitude),
      onTap: () {
        // Add navigation logic here if needed
      },
    );
  }
}