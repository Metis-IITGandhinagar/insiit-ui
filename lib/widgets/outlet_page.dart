// This file contains the OutletPage widget which is used to display the menu of a particular outlet.

import 'package:flutter/material.dart';
import 'package:insiit/database/db_helper.dart';
import 'package:insiit/model/cart_model.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../model/outlet.dart';
import 'package:badges/badges.dart' as badges;
import '../provider/cart_provider.dart';

class OutletPage extends StatelessWidget {
  final Outlet outlet;
  // final cart = Provider.of<CartProvider>(context);

  DBHelper dbHelper = DBHelper();

  OutletPage({required this.outlet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            pinned: true,
            expandedHeight: 200,
            // actions: [
            //   Center(
            //     child: Consumer<CartProvider>(
            //       builder: (context, value, child) {
            //         return badges.Badge(
            //           badgeContent: Text(
            //             '${value.getCounter()}',
            //             style: TextStyle(
            //               color: Colors.white,
            //             ),
            //           ),
            //           child: Icon(Icons.shopping_cart_outlined),
            //         );
            //       },
            //     ),
            //   ),
            //   const SizedBox(
            //     width: 10,
            //   ),
            //   IconButton(
            //       icon: const Icon(Icons.logout_sharp), onPressed: () async {}),
            //   const SizedBox(
            //     width: 15,
            //   ),
            // ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(outlet.name ?? 'Name Not Available',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 20,
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer)),
              background: Container(
                color: Theme.of(context)
                    .colorScheme
                    .secondaryContainer, // Plain dark background color
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = outlet.menu[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('₹' + '${item.price.toStringAsFixed(2)}'),
                  // trailing: OutlinedButton(
                  //   onPressed: () {
                  //     dbHelper
                  //         .insert(Cart(
                  //       productId: item.id,
                  //       productName: item.name,
                  //       unitPrice: item.price,
                  //       productPrice: item.price,
                  //       quantity: 1,
                  //       outletID: outlet.id,
                  //       outletName: outlet.name,
                  //     ))
                  //         .then((value) {
                  //       print('Item added to cart');
                  //       Provider.of<CartProvider>(context, listen: false)
                  //           .addCounter();
                  //       Provider.of<CartProvider>(context, listen: false)
                  //           .addTotalPrice(item.price);
                  //     }).catchError((error) {
                  //       print('Error adding item to cart: $error');
                  //     });

                  //     // Provider.of<CartProvider>(context, listen: false)
                  //     //     .addCounter();
                  //     // Provider.of<CartProvider>(context, listen: false)
                  //     //     .addTotalPrice(item.price);
                  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //     //   backgroundColor: Colors.green[900],
                  //     //   content: Text(item.name + " " + 'added to cart'),
                  //     // ));
                  //   },
                  //   child: Text('Add'),
                  // ),
                  onTap: () {},
                  visualDensity: VisualDensity.standard,
                );
              },
              childCount: outlet.menu.length,
            ),
          ),
        ],
      ),
    );
  }
}
