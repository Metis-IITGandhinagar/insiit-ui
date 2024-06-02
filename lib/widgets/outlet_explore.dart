// This file contains the OutletExplore widget which is used to display the list of outlets available in the app.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import '../model/outlet.dart';
import 'meal.dart';
import 'outlet_page.dart';
import '../provider/cart_provider.dart';


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
        .get(Uri.parse('http://10.7.17.57:3000/api/outlets'));
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: const Column(
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Explore Outlets',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Feeling Hungry? You have come to the right place. Explore and enjoy delicious foods here',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<Outlet>>(
              future: futureOutlets,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Outlet>? outlets = snapshot.data;
                  return ListView.builder(
                    itemCount: outlets!.length,
                    itemBuilder: (context, index) {
                      return OutletWidget(outlet: outlets[index]);
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                // By default, show a loading spinner
                return const Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                ));
              },
            ),
          ],
        ),
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
      subtitle: Text(outlet.openTime + ' - ' + outlet.closeTime),
      onTap: () {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => CartProvider(),
              child: OutletPage(outlet: outlet),
            ),
          ),
        );
      },
    );
  }
}
