import 'dart:convert';
import 'package:http/http.dart' as http;

class Outlet {
  final String id;
  final String name;
  final Location location;
  final String landmark;
  final String openTime;
  final String closeTime;
  final double rating;
  final List<MenuItem> menu;
  final String image;

  Outlet({
    required this.id,
    required this.name,
    required this.location,
    required this.landmark,
    required this.openTime,
    required this.closeTime,
    this.rating = 0.0,
    this.menu = const [],
    this.image = '',
  });

  factory Outlet.fromJson(Map<String, dynamic> json) {
  final List<dynamic> menuData = json['menu'] ?? [];
  final List<MenuItem> menuItems = menuData.map((item) => MenuItem.fromJson(item)).toList();

  return Outlet(
    id: json['_id'] ?? '', // Provide a default value for id if it's null
    name: json['name'] ?? '',
    location: Location.fromJson(json['location'] ?? {}),
    landmark: json['landmark'] ?? '',
    openTime: json['open_time'] ?? '',
    closeTime: json['close_time'] ?? '',
    rating: json['rating']?.toDouble() ?? 0.0,
    menu: menuItems,
    image: json['image'] ?? '',
  );
}

}

class Location {
  final String latitude;
  final String longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class MenuItem {
  final String id;
  final String name;
  final double price;
  final String description;
  final double rating;
  final String size;
  final double cal;
  final String image;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.description = '',
    this.rating = 0.0,
    this.size = '',
    this.cal = 0.0,
    this.image = '',
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
  return MenuItem(
    id: json['_id'] ?? '', // Provide a default value for id if it's null
    name: json['name'] ?? '',
    price: json['price']?.toDouble() ?? 0.0,
    description: json['description'] ?? '',
    rating: json['rating']?.toDouble() ?? 0.0,
    size: json['size'] ?? '',
    cal: json['cal']?.toDouble() ?? 0.0,
    image: json['image'] ?? '',
  );
}
}

Future<Outlet?> fetchOutlet() async {
  final response =
      await http.get(Uri.parse('https://insiit-backend-node.vercel.app/api/outlets'));
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(response.body);
    return Outlet.fromJson(responseData);
  } else {
    throw Exception('Failed to fetch outlet');
  }
}
