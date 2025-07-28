import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import './detailsPage.dart';

class TimeSlotPage extends StatefulWidget {
  TimeSlotPage({super.key, required this.initialDateIndex});
  final int initialDateIndex;

  @override
  State<TimeSlotPage> createState() => _TimeSlotPageState();
}

class _TimeSlotPageState extends State<TimeSlotPage> {
  bool isDataFetched = false;
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Response response =
        await get(Uri.parse("http://10.0.2.2:3000/api/haircut-slots"));
    if (response.body != null) {
      var fetchedData = jsonDecode(response.body);
      setState(() {
        isDataFetched = true;
        data = fetchedData["data"]; // Now it's a list
      });
    } else {
      print("Failed to get response");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataFetched) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return DefaultTabController(
      initialIndex: widget.initialDateIndex,
      length: data.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Haircut Bookings"),
          bottom: TabBar(isScrollable: true, tabs: [
            ...data.map((dateInfo) {
              return Tab(text: dateInfo['date']); // Use date from the new structure
            })
          ]),
        ),
        body: TabBarView(
          children: [
            ...data.map((dateInfo) {
              return Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.all(),
                    children: [
                      ...dateInfo['slots'].map((entry) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                // Format time as needed
				entry['time']
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: !entry['booked']
                                  ? TextButton(
                                      child: Text("Book"),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                              date: entry['date'],
                                              time: entry['time']
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Text("Booked"),
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

