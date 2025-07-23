// lib/widgets/cart_sheet.dart

import 'package:flutter/material.dart';
import 'package:insiit/model/cart_model.dart';
import 'package:insiit/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartSheet extends StatelessWidget {
  const CartSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Your Order',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),

          Expanded(
            child: FutureBuilder<List<Cart>>(
              future: cartProvider.cart,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Your cart is empty.'),
                  );
                }

                var cartItems = snapshot.data!;
                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return _buildCartItem(context, item, cartProvider);
                  },
                );
              },
            ),
          ),

          const Divider(),
          const SizedBox(height: 10),

          // Order Summary
          _buildOrderSummary(context, cartProvider),
          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                // TODO: actual checkout logic pending 
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Proceeding to checkout...')),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Proceed to Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(
      BuildContext context, Cart item, CartProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.itemName ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('₹${(item.unitPrice ?? 0).toStringAsFixed(2)}'),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () => provider.remove(item)),
              Text('${item.quantity}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () => provider.add(item)),
            ],
          ),
          // Total Price for item
          SizedBox(
            width: 70,
            child: Text(
              '₹${(item.itemPrice ?? 0).toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.red.shade700),
            onPressed: () => provider.delete(item.id!),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CartProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '₹${provider.totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
