import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BusPageStandalone extends StatefulWidget {
  const BusPageStandalone({super.key});

  @override
  State<BusPageStandalone> createState() => _BusPageStandaloneState();
}

class _BusPageStandaloneState extends State<BusPageStandalone> {
  List<String> towns = ['ANY','Palaj','Choose'];
  List<Map<String, dynamic>> data = [];
  String src = 'Palaj', des = 'ANY';

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
    Response response = await get(Uri.parse(
        'https://6baa0265-07c2-4b1c-b8bc-8fb7920eb5ee-00-kiqlob58lav7.pike.repl.co/towns'));
    List result = jsonDecode(response.body) as List;
    setState(() {
      towns.clear();
      towns.add('ANY');
      for (Map<String, dynamic> item in result) {
        String? townName = item['name'];
        if (townName != null) towns.add(townName);
      }
    });
  }

  void search() async {
    String url =
        'https://6baa0265-07c2-4b1c-b8bc-8fb7920eb5ee-00-kiqlob58lav7.pike.repl.co/buses?from=$src&to=$des';
    Response response = await get(Uri.parse(url));
    print(response.body);
    setState(() {
      data.clear();
      List items = jsonDecode(response.body) as List;
      for (Map<String, dynamic> item in items) {
        data.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchTowns();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Bus Schedule"),
      ),
      body:
      
       Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Row(
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
          ),
         const SizedBox(
            height: 10,
          ),
          TextButton.icon(
            icon: const Icon(Icons.search, color: Color.fromRGBO(94, 53, 177, 1)),
            onPressed: search,
            label: const Text(
              'Search     ',
              style: TextStyle(color: Color.fromRGBO(94, 53, 177, 1)),
            ),
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(212, 212, 255, 1),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
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
            color: const Color.fromARGB(255, 239, 233, 255), borderRadius: BorderRadius.circular(12)),
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
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(94, 53, 177, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Text(
                  '→',
                  style: TextStyle(
                      color: Color.fromRGBO(94, 53, 177, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data['Destination']!,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(94, 53, 177, 1),
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
                const Icon(
                  Icons.access_time,
                  color: Color.fromRGBO(94, 53, 177, 1),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'Departure Time ' + data['DepartureTime'],
                    maxLines: 2,
                    style: const TextStyle(
                      color: Color.fromRGBO(94, 53, 177, 1),
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
                const Icon(
                  Icons.directions,
                  color: Color.fromRGBO(94, 53, 177, 1),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    'Via ' + data['Stops'].join(', '),
                    maxLines: 2,
                    style: const TextStyle(
                      color: Color.fromRGBO(94, 53, 177, 1),
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
                const Icon(
                  Icons.directions_bus,
                  color: Color.fromRGBO(94, 53, 177, 1),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  data['BusName']!,
                  style: const TextStyle(color: Color.fromRGBO(94, 53, 177, 1)),
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
