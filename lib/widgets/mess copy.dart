import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:rotating_icon_button/rotating_icon_button.dart';
import 'package:intl/intl.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});
  static const List<String> weekDays = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Map<String, dynamic> weeklyMenu = {};

  Widget buildDailyMenu(String day, String mealType) {
    if (weeklyMenu['menu'] != null &&
        weeklyMenu['menu'][day] != null &&
        weeklyMenu['menu'][day][mealType] != null) {
      List<dynamic> meals = weeklyMenu['menu'][day][mealType];

      if (meals != null && meals.isNotEmpty) {
        return ExpansionTile(
          title: Text('$mealType'.toUpperCase()),
          children: <Widget>[
            for (var meal in meals)
              ListTile(
                  title: Text(
                meal['name'],
                style: TextStyle(fontSize: 15),
              )),
          ],
        );
      }
    }

    return Container(); // Return an empty container if there are no meals for the specified day and meal type
  }

  Future<void> fetchMenu() async {
    final response = await http
        .get(Uri.parse('https://insiit-api.onrender.com/mess/2/menu'));
    final extractedData = json.decode(response.body);
    print(extractedData);
    setState(() {
      weeklyMenu = extractedData;
      print(weeklyMenu);
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('weeklyMenu', json.encode(extractedData));
  }

  Future<Map<String, dynamic>> loadMenuFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('weeklyMenu')) {
      return json.decode(prefs.getString('weeklyMenu')!);
    } else {
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    loadMenuFromPrefs().then((data) {
      if (data.isEmpty) {
        fetchMenu();
      } else {
        setState(() {
          weeklyMenu = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday'
    ];
    final mealList = ["breakfast", "lunch", "snacks", "dinner"];
    String today() {
      return DateFormat('EEEE').format(DateTime.now()).toLowerCase();
    }

    var todayname = today();
    final TimeOfDay now = TimeOfDay.now();
    // print(todayname);
    var day = DateFormat('EEEE').format(DateTime.now()).toLowerCase();
    return FutureBuilder(
      future: loadMenuFromPrefs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          if (weeklyMenu.isEmpty) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return DefaultTabController(
                // key: ,
                initialIndex: Menu.weekDays.indexOf(
                  day,
                ),
                length: 7,
                child: Scaffold(
                  appBar: AppBar(
                    actionsIconTheme: IconThemeData(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    actions: [
                      RotatingIconButton(
                        background:
                            Theme.of(context).colorScheme.secondaryContainer,
                        onTap: () async {
                          await fetchMenu();
                        },
                        child: const Icon(Icons.refresh),
                      ),
                    ],
                    title: Text(
                      "Mess Menu",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                    centerTitle: true,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    elevation: 0,
                    bottom: TabBar(
                      isScrollable: true,
                      tabs: <Widget>[
                        ...Menu.weekDays
                            .map((e) => Tab(
                                  child: Text(
                                    e.toUpperCase(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer),
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      ...Menu.weekDays.map(
                        (e) => ListView.builder(
                          physics: const ScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (ctx, index) => buildDailyMenu(
                            e,
                            mealList[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }
        }
      },
    );
  }
}