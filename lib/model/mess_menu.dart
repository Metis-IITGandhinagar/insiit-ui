import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class MessMenu {
  final String id;
  final String messName;
  final List<MenuDay> mess;

  MessMenu({
    required this.id,
    required this.messName,
    required this.mess,
  });

  factory MessMenu.fromJson(Map<String, dynamic> json) {
    List<MenuDay> menuDays = (json['mess'] as List<dynamic>)
        .map((day) => MenuDay.fromJson(day))
        .toList();

    return MessMenu(
      id: json['id'],
      messName: json['mess_name'],
      mess: menuDays,
    );
  }
}

class MenuDay {
  final int? day;
  final String? breakfast;
  final String? lunch;
  final String? snacks;
  final String? dinner;

  MenuDay({
    this.day,
    this.breakfast,
    this.lunch,
    this.snacks,
    this.dinner,
  });

  factory MenuDay.fromJson(Map<String, dynamic> json) {
    return MenuDay(
      day: json['day'],
      breakfast: json['breakfast'],
      lunch: json['lunch'],
      snacks: json['snacks'],
      dinner: json['dinner'],
    );
  }
}
class MenuService {
  Future<MessMenu?> fetchMenu() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // fetch cached data
    final String? cachedData = prefs.getString('cachedMenu');
    final int? cacheTimestamp = prefs.getInt('cacheTimestamp');

    // Check if cached data exists and if it's not expired
    if (cachedData != null && cacheTimestamp != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final difference = currentTime - cacheTimestamp;
      if (difference < (24 * 60 * 60 * 1000)) { //24hr

        return MessMenu.fromJson(json.decode(cachedData));
      }
    }

    final response = await http.get(Uri.parse('http://10.7.17.57:3000/api/mess-menu'));
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final messMenu = MessMenu.fromJson(responseData);
      
      // Cache fetched data
      await prefs.setString('cachedMenu', response.body);
      await prefs.setInt('cacheTimestamp', DateTime.now().millisecondsSinceEpoch);
      
      return messMenu;
    } else {
      throw Exception('Failed to load menu');
    }
  }
}