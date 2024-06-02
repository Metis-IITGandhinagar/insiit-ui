import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insiit/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'events_details.dart';
import 'mess.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/outlets.dart';
import 'bus_standalone.dart';
import 'events.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/events.dart';
import 'dart:async';
import 'package:insiit/model/mess_menu.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var name = FirebaseAuth.instance.currentUser!.displayName ?? "User";

var nameArray = name?.split(" ");

var userdata = FirebaseAuth.instance.currentUser!;

class _HomePageState extends State<HomePage> {
  late Future<MessMenu?> _menuFuture;
  MenuService _menuService = MenuService();

  @override
  void initState() {
    super.initState();
    _menuFuture = _menuService.fetchMenu();
  }

  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  Future<List<Events>> postsFuture = getPosts();

  static Future<List<Events>> getPosts() async {
    var url = Uri.parse("http://10.7.17.57:3000/api/events");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Events.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final TimeOfDay now = TimeOfDay.now();
    print(now);
    print(userdata);
    final pages = List.generate(
      6,
      (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 233, 236, 255),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
          height: 180,
          child: Center(
              child: Text(
            "Event $index",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          )),
        ),
      ),
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hi, ${nameArray?[0]}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Welcome Back!!",
                        style: TextStyle(fontSize: 15)),
                  ],
                ),
              ],
            ),
          ),

          // const SizedBox(
          //   height: 10,
          // ),

          Row(children: [
            Card(
                surfaceTintColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                color: Theme.of(context).colorScheme.secondaryContainer,
                margin: const EdgeInsets.all(16.0),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  splashColor: const Color.fromARGB(103, 159, 111, 255),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BusPageStandalone()),
                    );
                  },
                  child: SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 2 -
                        32, // minus 32 due to the margin

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_bus_filled_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        Text(
                          "Bus Schedule",
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Card(
                surfaceTintColor: Colors.white,
                color: Theme.of(context).colorScheme.tertiaryContainer,
                margin: const EdgeInsets.all(16.0),
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  splashColor: const Color.fromARGB(123, 255, 166, 121),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const OutletScreen()),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => CartProvider(),
                          child: OutletScreen(),
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 2 -
                        32, // minus 32 due to the margin

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant_menu_outlined,
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                        Text(
                          "Outlets",
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ]),
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EventWidget()),
              );
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text("What's on the Campus?",
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const EventWidget()));
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ],
                )
                // const ListTile(

                //   leading: Icon(Icons.food_bank_outlined),
                //   title: Text("What is in the Mess?"),
                //   trailing: IconButton(onPressed: (), icon: icon)
                // ),
                ),
          ),
          SafeArea(
            child: FutureBuilder<List<Events>>(
              future: postsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else {
                  final events = snapshot.data;
                  final currentDate = DateTime.now();
                  final previousDate =
                      currentDate.subtract(const Duration(days: 1));

                  final futureEvents = events?.where((event) {
                    if (event?.date == null) return false;
                    final eventDate = DateTime.parse(event!.date!);
                    return eventDate.isAfter(previousDate);
                  }).toList();

                  final sortedEvents = futureEvents?.where((event) {
                    if (event.date == null) return false;
                    final eventDate = DateTime.parse(event.date!);
                    return eventDate.isAfter(previousDate);
                  }).toList();

                  sortedEvents?.sort((a, b) {
                    final aDate = DateTime.parse(a.date!);
                    final bDate = DateTime.parse(b.date!);
                    return aDate.compareTo(bDate);
                  });

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 16),
                        sortedEvents?.isEmpty ?? true
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'No Events Added!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 180,
                                child: PageView.builder(
                                  controller: controller,
                                  itemCount: min(sortedEvents?.length ?? 0, 6),
                                  itemBuilder: (_, index) {
                                    final event = sortedEvents?[index];
                                    return InkWell(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0),
                                      ),
                                      splashColor: const Color.fromARGB(
                                          103, 159, 111, 255),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EventDetailsPage(
                                              event: sortedEvents?[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                NetworkImage("${event?.image}"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.black.withOpacity(0),
                                                Colors.black.withOpacity(.6),
                                              ],
                                            ),
                                          ),
                                          height: 280,
                                          child: Center(
                                            child: Text(
                                              event?.name ??
                                                  'Events Not Available',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4, bottom: 12),
                        ),
                        SmoothPageIndicator(
                          controller: controller,
                          count: min(sortedEvents?.length ?? 0, 6),
                          effect: const WormEffect(
                            dotHeight: 6,
                            dotWidth: 6,
                            type: WormType.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),

          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuPage()),
              );
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Text("What's in the Mess?",
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => MenuPage()));
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                    ])
                // const ListTile(

                //   leading: Icon(Icons.food_bank_outlined),
                //   title: Text("What is in the Mess?"),
                //   trailing: IconButton(onPressed: (), icon: icon)
                // ),
                ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<MessMenu?>(
                future: _menuFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    MessMenu? menu = snapshot.data;
                    MenuDay? todayMenu = _getTodayMenu(menu);
                    DateTime now = DateTime.now();
                    if (todayMenu != null) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            if (now.hour < 11)
                              Row(
                                children: [
                                  // SizedBox(height: 50),
                                  _buildMealTile(
                                      'Breakfast', todayMenu.breakfast),
                                ],
                              )
                            else if (now.hour < 15)
                              Row(
                                children: [
                                  // SizedBox(height: 50),
                                  _buildMealTile('Lunch', todayMenu.lunch),
                                ],
                              )
                            else if (now.hour < 18)
                              Row(
                                children: [
                                  // SizedBox(height: 50),
                                  _buildMealTile('Snacks', todayMenu.snacks),
                                ],
                              )
                            else if (now.hour < 23)
                              Row(
                                children: [
                                  // SizedBox(height: 50),
                                  _buildMealTile('Dinner', todayMenu.dinner),
                                ],
                              )
                            else
                              Row(
                                children: [
                                  // SizedBox(height: 50),
                                  _buildMealTile(
                                      'Breakfast', todayMenu.breakfast),
                                ],
                              )
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text('Menu data not available for today.'),
                      );
                    }
                  } else {
                    return Center(
                      child: Text('No menu data available'),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 90,
              ),
            ],
          )
        ]));
  }

  Widget _buildMealTile(String mealType, String? meal) {
    return Container(
      width: MediaQuery.of(context).size.width - 16,
      height: 330,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .secondaryContainer, // Light purple color
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              mealType.toUpperCase(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            SizedBox(height: 12),
            Text(
              meal ?? 'Not available',
              style: TextStyle(
                height: 1.5,
                fontSize: 14,
                fontStyle: meal == null ? FontStyle.italic : FontStyle.normal,
                color: meal == null
                    ? Theme.of(context).colorScheme.onSecondaryContainer
                    : Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  MenuDay? _getTodayMenu(MessMenu? menu) {
    DateTime now = DateTime.now();
    int currentWeekday =
        now.weekday; // 1 for Monday, 2 for Tuesday, ..., 7 for Sunday
    MenuDay? todayMenu;

    if (menu != null) {
      todayMenu = menu.mess.firstWhere((day) => day.day == currentWeekday);
      if (todayMenu != null) {
        if (now.hour < 11) {
          // Show breakfast
          return MenuDay(
            day: todayMenu.day,
            breakfast: todayMenu.breakfast,
          );
        } else if (now.hour < 15) {
          // Show lunch
          return MenuDay(
            day: todayMenu.day,
            lunch: todayMenu.lunch,
          );
        } else if (now.hour < 18) {
          // Show snacks
          return MenuDay(
            day: todayMenu.day,
            snacks: todayMenu.snacks,
          );
        } else if (now.hour < 23) {
          // Show dinner
          return MenuDay(
            day: todayMenu.day,
            dinner: todayMenu.dinner,
          );
        } else {
          // Show breakfast for late night hours
          return MenuDay(
            day: todayMenu.day,
            breakfast: todayMenu.breakfast,
          );
        }
      }
    }

    return todayMenu; // Return null if no menu is found or menu is null
  }
}
