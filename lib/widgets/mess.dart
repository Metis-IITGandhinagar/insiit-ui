// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:rotating_icon_button/rotating_icon_button.dart';
// import 'package:intl/intl.dart';

// class Menu extends StatefulWidget {
//   const Menu({Key? key}) : super(key: key);

//   @override
//   State<Menu> createState() => _MenuState();
// }

// class _MenuState extends State<Menu> {
//   late Map<String, dynamic> weeklyMenu;

//   @override
//   void initState() {
//     super.initState();
//     weeklyMenu = {};
//     loadMenuFromPrefs().then((data) {
//       if (data.isEmpty) {
//         fetchMenu();
//       } else {
//         setState(() {
//           weeklyMenu = data;
//         });
//       }
//     });
//   }

//   Future<void> fetchMenu() async {
//     final response =
//         await http.get(Uri.parse('http://10.7.39.171:3000/api/mess-menu'));
//     final extractedData = json.decode(response.body);
//     setState(() {
//       weeklyMenu = extractedData.mess;
//     });
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('weeklyMenu', json.encode(extractedData));
//   }

//   Future<Map<String, dynamic>> loadMenuFromPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey('weeklyMenu')) {
//       return json.decode(prefs.getString('weeklyMenu')!);
//     } else {
//       return {};
//     }
//   }

//   Widget buildDailyMenu(String day, String mealType) {
//     if (weeklyMenu['mess'] != null) {
//       for (var menu in weeklyMenu['mess']) {
//         if (menu['day'] == day) {
//           return ExpansionTile(
//             title: Text('$mealType'.toUpperCase()),
//             children: <Widget>[
//               ListTile(
//                 title: Text(menu[mealType]),
//               ),
//             ],
//           );
//         }
//       }
//     }
//     return Container(); // Return an empty container if menu data is not available
//   }

//   @override
//   Widget build(BuildContext context) {
//     final weekdays = [
//       'monday',
//       'tuesday',
//       'wednesday',
//       'thursday',
//       'friday',
//       'saturday',
//       'sunday'
//     ];

//     final String today = DateFormat('EEEE').format(DateTime.now()).toLowerCase();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mess Menu'),
//         actions: [
//           RotatingIconButton(
//             background: Theme.of(context).colorScheme.secondary,
//             onTap: () async {
//               await fetchMenu();
//             },
//             child: const Icon(Icons.refresh),
//           ),
//         ],
//       ),
//       body: DefaultTabController(
//         length: 7,
//         initialIndex: weekdays.indexOf(today),
//         child: Column(
//           children: [
//             TabBar(
//               isScrollable: true,
//               tabs: weekdays
//                   .map((day) => Tab(
//                         child: Text(
//                           day.toUpperCase(),
//                         ),
//                       ))
//                   .toList(),
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: weekdays
//                     .map((day) => ListView.builder(
//                           itemCount: 4,
//                           itemBuilder: (context, index) {
//                             final mealType = ['breakfast', 'lunch', 'snacks', 'dinner'][index];
//                             return buildDailyMenu(day, mealType);
//                           },
//                         ))
//                     .toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../model/mess_menu.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Future<MessMenu?> _menuFuture;
  MenuService _menuService = MenuService();

  @override
  void initState() {
    super.initState();
    _menuFuture = _menuService.fetchMenu();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MessMenu?>(
      future: _menuFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData) {
          MessMenu? menu = snapshot.data;
          return DefaultTabController(
               initialIndex: DateTime.now().weekday - 1,
            length: menu!.mess.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text(menu.messName),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: menu.mess.map((dayMenu) {
                    return Tab(
                      text: _getWeekday(dayMenu.day), // Get weekday name
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: menu.mess.map((dayMenu) {
                  return ListView(
                    children: [
                      _buildMealTile('Breakfast', dayMenu.breakfast),
                      _buildMealTile('Lunch', dayMenu.lunch),
                      _buildMealTile('Snacks', dayMenu.snacks),
                      _buildMealTile('Dinner', dayMenu.dinner),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('No Data'),
            ),
            body: Center(
              child: Text('No menu data available'),
            ),
          );
        }
      },
    );
  }

  Widget _buildMealTile(String mealType, String? meal) {
    return ExpansionTile(
      title: Text(
        mealType,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            meal ?? 'Not available',
            style: TextStyle(
              
              fontStyle: meal == null ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }

  String _getWeekday(int? dayNumber) {
    // Convert day number to weekday name
    switch (dayNumber) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }
}