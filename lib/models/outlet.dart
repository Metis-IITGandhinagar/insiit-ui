// class Outlet {
//   Outlet({
//     this.id,
//     this.name,
//     this.location,
//     this.landmark,
//     this.open,
//     this.close,
//     this.rating,
//     this.menu,
//     this.image,
//   });

//   int? id;
//   String? name;
//   Null location;
//   String? landmark;
//   String? open;
//   String? close;
//   Null rating;
//   Null menu;
//   String? image;

//     Outlet.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     location = json['location'];
//     landmark = json['landmark'];
//     open = json['open_time'];
//     close = json['close_time'];
//     rating = json['rating'];
//     image = json['image'];
//     location = json['location'];

//   }
// }
class Outlet {
  final int id;
  final String name;
  final String location;
  final String landmark;
  final String openTime;
  final String closeTime;
  final double rating;
  final List<MenuItem> menu;
  final String image;

  Outlet({
    required this.id,
    required this.name,
    this.location = "",
    required this.landmark,
    required this.openTime,
    required this.closeTime,
    this.rating = 0.0,
    this.menu = const <MenuItem>[],
    this.image = "",
  });

  factory Outlet.fromJson(Map<String, dynamic> json) {
    final List<dynamic> menuData = json['menu'] ?? <dynamic>[];
    final List<MenuItem> menuItems =
        menuData.map((item) => MenuItem.fromJson(item)).toList();

    return Outlet(
      id: json['id'],
      name: json['name'],
      location: json['location'] ?? "",
      landmark: json['landmark'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
      rating: json['rating'] ?? 0.0,
      menu: menuItems,
      image: json['image'] ?? "",
    );
  }
}

class MenuItem {
  final int id;
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
    this.description = "",
    this.rating = 0.0,
    this.size = "",
    this.cal = 0.0,
    this.image = "",
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'] ?? "",
      rating: json['rating'] ?? 0.0,
      size: json['size'] ?? "",
      cal: json['cal'] ?? 0.0,
      image: json['image'] ?? "",
    );
  }
}