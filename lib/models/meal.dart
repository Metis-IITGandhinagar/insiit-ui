// class Meal {
//   const Meal({
//     required this.id,
//     required this.categories,
//     required this.title,
//     required this.cost,
//     required this.outlet,
//     required this.imageUrl,
//     required this.isVeg,
//     required this.reviews,
//   });

//   final String id;
//   final List<String> categories;
//   final String title;
//   final int cost;
//   final String outlet;
//   final String imageUrl;
//   final bool isVeg;
//   final double reviews;
// }
// Instead of giving numeric ids we could give enum ids.

enum OutletName {
  vs,
  go,
  dawat,
}

class Meal {
  Meal({
    required this.id,
    required this.name,
    required this.price,
    // required this.description,
    // required this.isVeg,
    // required this.rating,
    // required this.size,
    // required this.cal,
    // required this.image,
    required this.outletid,
  });

  int? id;
  String name;
  int? price;
  // String? description;
  // final bool isVeg;
  // Map<String, double>? rating;
  // String? size;
  // int? cal;
  // String? image;
  int outletid;
}
