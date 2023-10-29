// Instead of giving numeric ids we could give enum ids.
enum OutletName{
  vs,
  go,
  dawat,
}

class Meal {
  const Meal({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    // required this.isVeg,
    required this.rating,
    required this.size,
    required this.cal,
    required this.image,
    required this.outletid,
  });

  final String id;
  final String name;
  final int price;
  final String description;
  // final bool isVeg;
  final Map<String, double> rating;
  final String size;
  final int cal;
  final String image;
  final int outletid;
}

String getOutletName(int outletid) {
  switch (outletid) {
    case 1:
      return "VS Fastfood";
    case 2:
      return "Dawat Foods";
    case 3:
      return "Go Insta Cafe";
    // Add more cases for additional outlets
    default:
      return "Unknown Outlet";
  }
}