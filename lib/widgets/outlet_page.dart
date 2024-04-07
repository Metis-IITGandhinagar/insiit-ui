import 'package:flutter/material.dart';
import '../model/outlet.dart';

class OutletPage extends StatelessWidget {
  final Outlet outlet;

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
                  trailing: Text('₹' + '${item.price.toStringAsFixed(2)}'),
                  onTap: () {
                    // Handle item selection
                  },
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
