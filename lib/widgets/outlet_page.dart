import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/outlet.dart';
class OutletPage extends StatelessWidget {
  final Outlet outlet;

  OutletPage({required this.outlet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(outlet.name),
      ),
      body: Column(
        children: outlet.menu.map((item) {
          return ListTile(
            title: Text(item.name),
            subtitle: Text('₹' +'${item.price.toStringAsFixed(2)}'),
          );
        }).toList(),
      ),
    );
  }
}
