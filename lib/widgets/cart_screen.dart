import 'package:flutter/material.dart';
import 'package:insiit/model/cart_model.dart';
import 'package:insiit/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import '../database/db_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
        body: Column(
      children: [
        FutureBuilder(
            future: cart.getCart(),
            builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].productName ?? ''),
                        subtitle:
                            Text(snapshot.data![index].unitPrice.toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            //TODO: Delete item from cart
                            dbHelper
                                .delete(snapshot.data![index].id!)
                                .then((value) {
                              Provider.of<CartProvider>(context, listen: false)
                                  .removeCounter();
                                  
                              setState(() {});
                            }).catchError((error) {
                              print("Error: $error");
                            });
                          },
                        ),
                      );
                    },
                  ),
                );
              }
            }),
      ],
    ));
  }
}
