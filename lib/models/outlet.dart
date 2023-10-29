class Outlet {
  const Outlet({
    required this.id,
    required this.name,
    required this.location,
    required this.landmark,
    required this.open,
    required this.close,
    required this.rating,
    required this.menu,
    required this.image,
  });

  final String id;
  final String name;
  final Map<String, double> location;
  final String landmark;
  final DateTime open;
  final DateTime close;
  final Map<String, double> rating;
  final Map<String, double> menu;
  final String image;
}
