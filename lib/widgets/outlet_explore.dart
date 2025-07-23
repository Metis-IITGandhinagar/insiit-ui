// This file contains the OutletExplore widget which is used to display the list of outlets available in the app.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import '../model/outlet.dart';
import 'meal.dart';
import 'outlet_page.dart';
import '../provider/cart_provider.dart';
import 'outlet_card.dart';

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
    final response = await http
        .get(Uri.parse('https://insiit-backend-node.vercel.app/api/outlets'));
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 2));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            List<Outlet>? outlets = snapshot.data;
            return ListView.builder(
              itemCount: outlets!.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildHeader(context);
                }

                return OutletCard(outlet: outlets[index - 1]);
              },
            );
          }
          return const Center(child: Text('No outlets found.'));
        },
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore Outlets',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Feeling Hungry? You have come to the right place. Explore and enjoy delicious foods here.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
