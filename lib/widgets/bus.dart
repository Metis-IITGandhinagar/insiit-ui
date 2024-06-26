import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BusPage extends StatefulWidget {
  const BusPage({Key? key});

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  List<String> towns = ['ANY', 'IIT Gandhinagar', 'Choose'];
  List<Map<String, dynamic>> data = [];
  String src = 'IIT Gandhinagar', des = 'ANY';
  bool searching = false;
  bool townsFetched = false; // Flag to track whether towns are fetched

  @override
  void initState() {
    super.initState();
    fetchTowns();
  }

  void setSrc(String? t) {
    setState(() {
      src = t ?? towns[0];
    });
  }

  void setDes(String? t) {
    setState(() {
      des = t ?? towns[0];
    });
  }

  void fetchTowns() async {
    Response response = await get(
        Uri.parse('https://insiit-backend-node.vercel.app/api/towns'));
    List result = jsonDecode(response.body) as List;
    setState(() {
      towns.clear();
      towns.add('ANY');
      Set<String> townNames = Set(); // Use a set to ensure uniqueness
      for (Map<String, dynamic> item in result) {
        String? townName = item['name'];
        if (townName != null && !townNames.contains(townName)) {
          towns.add(townName);
          townNames.add(townName); // Add the town name to the set
        }
      }
      townsFetched = true; // Set the flag to true after fetching towns
    });
  }

  void search() async {
    setState(() {
      searching = true;
    });

    String url =
        'https://insiit-backend-node.vercel.app/api/search?source=$src&destination=$des';
    Response response = await get(Uri.parse(url));
    print(response.body);
    setState(() {
      searching = false;
      data.clear();
      List items = jsonDecode(response.body) as List;
      for (Map<String, dynamic> item in items) {
        data.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          townsFetched // Only show dropdowns if towns are fetched
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('SOURCE'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton(
                              value: src,
                              items: towns.map((element) {
                                return DropdownMenuItem(
                                    value: element, child: Text(element));
                              }).toList(),
                              onChanged: setSrc),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('DESTINATION'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton(
                              value: des,
                              items: towns.map((element) {
                                return DropdownMenuItem(
                                    value: element, child: Text(element));
                              }).toList(),
                              onChanged: setDes),
                        ),
                      ],
                    ),
                  ],
                )
              : CircularProgressIndicator(), // Show loading indicator if towns are not fetched
          const SizedBox(
            height: 10,
          ),
          TextButton.icon(
            icon: Icon(Icons.search,
                color: Theme.of(context).colorScheme.secondaryContainer),
            onPressed: () {
              search();
            },
            label: Text(
              'Search     ',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondaryContainer),
            ),
            style: TextButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          searching
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, i) => BusCard(data: data[i])),
                ),
        ],
      ),
    );
  }
}

class BusCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const BusCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12)),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['Source']!,
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '→',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data['Destination']!,
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'Departure Time ' + data['DepartureTime'],
                    maxLines: 2,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(
                  Icons.directions,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'Via ' + data['Stops'].join(', '),
                    maxLines: 2,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.directions_bus,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  data['BusName']!,
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
