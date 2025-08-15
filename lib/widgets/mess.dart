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
                backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
                bottom: TabBar(
                  isScrollable: true,
                  tabs: menu.mess.map((dayMenu) {
                    return Tab(
                      text: _getWeekday(dayMenu.day), // Get weekday name
                    );
                  }).toList(),
                ),        
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      setState(() {
                        _menuFuture = _menuService.fetchMenu();
                      });
                    },
                  ),
                  const SizedBox(width: 15),
                ],
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
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Align(
            alignment: Alignment.centerLeft, // Align text to the left
            child: Text(
              meal ?? 'Not available',
              style: TextStyle(
                fontStyle: meal == null ? FontStyle.italic : FontStyle.normal,
                height: 2.5,
              ),
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
