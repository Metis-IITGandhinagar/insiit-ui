import 'package:flutter/material.dart';

import '../models/outlet.dart';

class OutletCard extends StatelessWidget {
  const OutletCard({super.key, required this.outlet});

  final Outlet outlet;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        outlet.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          Text(
                            outlet.landmark,
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.timer),
                          Text(
                            "${outlet.open} - ${outlet.close}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                  child: Image(image: AssetImage(outlet.image)),
                ),
              ],
            ),
            Container(
              color: Colors.green[300],
              child: InkWell(
                child: const Text('Check the menu'),
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
