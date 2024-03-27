import 'package:http/http.dart' as http;
import 'dart:convert';

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
    final response =
        await http.get(Uri.parse('http://10.7.39.171:3000/api/mess-menu'));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      return MessMenu.fromJson(responseData);
    } else {
      throw Exception('Failed to load menu');
    }
  }
}
