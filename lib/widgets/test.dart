import 'package:flutter/material.dart';
import 'package:insiit/model/mess_menu.dart';
import 'package:intl/intl.dart'; // For date formatting

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  late Future<MessMenu?> _menuFuture;
  MenuService _menuService = MenuService();

  @override
  void initState() {
    super.initState();
    _menuFuture = _menuService.fetchMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Menu'),
      ),
      body: FutureBuilder<MessMenu?>(
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
                          _buildMealTile('Breakfast', todayMenu.breakfast),
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
                          _buildMealTile('Breakfast', todayMenu.breakfast),
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
    );
  }

  Widget _buildMealTile(String mealType, String? meal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$mealType:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          meal ?? 'Not available',
          style: TextStyle(
            fontStyle: meal == null ? FontStyle.italic : FontStyle.normal,
          ),
        ),
        SizedBox(height: 10),
      ],
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
