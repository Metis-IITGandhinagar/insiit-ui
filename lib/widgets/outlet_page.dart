// // This file contains the OutletPage widget which is used to display the menu of a particular outlet.

// import 'package:flutter/material.dart';
// import 'package:insiit/database/db_helper.dart';
// import 'package:insiit/model/cart_model.dart';
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';
// import '../model/outlet.dart';
// import 'package:badges/badges.dart' as badges;
// import '../provider/cart_provider.dart';

// class OutletPage extends StatelessWidget {
//   final Outlet outlet;
//   // final cart = Provider.of<CartProvider>(context);

//   DBHelper dbHelper = DBHelper();

//   OutletPage({required this.outlet});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             floating: false,
//             backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
//             pinned: true,
//             expandedHeight: 200,
//             // actions: [
//             //   Center(
//             //     child: Consumer<CartProvider>(
//             //       builder: (context, value, child) {
//             //         return badges.Badge(
//             //           badgeContent: Text(
//             //             '${value.getCounter()}',
//             //             style: TextStyle(
//             //               color: Colors.white,
//             //             ),
//             //           ),
//             //           child: Icon(Icons.shopping_cart_outlined),
//             //         );
//             //       },
//             //     ),
//             //   ),
//             //   const SizedBox(
//             //     width: 10,
//             //   ),
//             //   IconButton(
//             //       icon: const Icon(Icons.logout_sharp), onPressed: () async {}),
//             //   const SizedBox(
//             //     width: 15,
//             //   ),
//             // ],
//             flexibleSpace: FlexibleSpaceBar(
//               title: Text(outlet.name ?? 'Name Not Available',
//                   textAlign: TextAlign.justify,
//                   style: TextStyle(
//                       fontSize: 20,
//                       color:
//                           Theme.of(context).colorScheme.onSecondaryContainer)),
//               background: Container(
//                 color: Theme.of(context)
//                     .colorScheme
//                     .secondaryContainer, // Plain dark background color
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 final item = outlet.menu[index];
//                 return ListTile(
//                   title: Text(item.name),
//                   subtitle: Text('₹' + '${item.price.toStringAsFixed(2)}'),
//                   // trailing: OutlinedButton(
//                   //   onPressed: () {
//                   //     dbHelper
//                   //         .insert(Cart(
//                   //       itemId: item.id,
//                   //       itemName: item.name,
//                   //       unitPrice: item.price,
//                   //       itemPrice: item.price,
//                   //       quantity: 1,
//                   //       outletID: outlet.id,
//                   //       outletName: outlet.name,
//                   //     ))
//                   //         .then((value) {
//                   //       print('Item added to cart');
//                   //       Provider.of<CartProvider>(context, listen: false)
//                   //           .addCounter();
//                   //       Provider.of<CartProvider>(context, listen: false)
//                   //           .addTotalPrice(item.price);
//                   //     }).catchError((error) {
//                   //       print('Error adding item to cart: $error');
//                   //     });

//                   //     // Provider.of<CartProvider>(context, listen: false)
//                   //     //     .addCounter();
//                   //     // Provider.of<CartProvider>(context, listen: false)
//                   //     //     .addTotalPrice(item.price);
//                   //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   //     //   backgroundColor: Colors.green[900],
//                   //     //   content: Text(item.name + " " + 'added to cart'),
//                   //     // ));
//                   //   },
//                   //   child: Text('Add'),
//                   // ),
//                   onTap: () {},
//                   visualDensity: VisualDensity.standard,
//                 );
//               },
//               childCount: outlet.menu.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:insiit/database/db_helper.dart';
import 'package:insiit/model/cart_model.dart';
import 'package:provider/provider.dart';
import '../model/outlet.dart';
import 'package:badges/badges.dart' as badges;
import '../provider/cart_provider.dart';
import 'cart_sheet.dart';

class OutletPage extends StatelessWidget {
  final Outlet outlet;

  const OutletPage({super.key, required this.outlet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return cart.counter == 0
              ? const SizedBox.shrink() 
              : FloatingActionButton.extended(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, 
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.75, 
                        child: const CartSheet(),
                      ),
                    );
                  },
                  label: Text('${cart.counter} items'),
                  icon: const Icon(Icons.shopping_bag_outlined),
                );
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                outlet.name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: outlet.image.isNotEmpty
                  ? Image.network(
                      outlet.image,
                      fit: BoxFit.cover,
                      color: Colors.black
                          .withOpacity(0.3), 
                      colorBlendMode: BlendMode.darken,
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    outlet.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (outlet.landmark.isNotEmpty)
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          outlet.landmark,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        '${outlet.openTime} - ${outlet.closeTime}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = outlet.menu[index];
                return MenuItemWidget(outlet: outlet, item: item);
              },
              childCount: outlet.menu.length,
            ),
          ),
        ],
      ),
    );
  }
}


class MenuItemWidget extends StatelessWidget {
  final Outlet outlet;
  final MenuItem item;
  final DBHelper dbHelper = DBHelper();

  MenuItemWidget({
    super.key,
    required this.outlet,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.image.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                item.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.fastfood, size: 60, color: Colors.grey),
              ),
            ),
          if (item.image.isNotEmpty) const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${item.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              List<Cart> currentCart = await cartProvider.db.getCartList();
              if (currentCart.isNotEmpty &&
                  currentCart.first.outletID != outlet.id) {
                _showOutletMismatchDialog(context, cartProvider, item);
              } else {
                cartProvider.add(Cart(
                  itemId: item.id,
                  itemName: item.name,
                  unitPrice: item.price,
                  itemPrice: item.price,
                  quantity: 1,
                  outletID: outlet.id,
                  outletName: outlet.name,
                ));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green.shade800,
                  content: Text('${item.name} added to cart',
                      style: TextStyle(color: Colors.white)),
                  duration: const Duration(seconds: 1),
                ));
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showOutletMismatchDialog(
      BuildContext context, CartProvider provider, MenuItem newItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Start New Order?'),
          content: const Text(
              'Your cart contains items from another outlet. Would you like to clear the cart and start a new order?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes, Clear Cart'),
              onPressed: () {
                // Clear the cart, then add the new item
                provider.clear().then((_) {
                  provider.add(Cart(
                    itemId: newItem.id,
                    itemName: newItem.name,
                    unitPrice: newItem.price,
                    itemPrice: newItem.price,
                    quantity: 1,
                    outletID: outlet.id,
                    outletName: outlet.name,
                  ));
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green.shade800,
                  content: Text('New order started. ${newItem.name} added.',
                      style: const TextStyle(color: Colors.white)),
                  duration: const Duration(seconds: 2),
                ));
              },
            ),
          ],
        );
      },
    );
  }
}
