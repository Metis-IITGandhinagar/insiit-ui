class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.cost,
    required this.outlet,
    required this.imageUrl,
    required this.isVeg,
    required this.reviews,
  });

  final String id;
  final List<String> categories;
  final String title;
  final int cost;
  final String outlet;
  final String imageUrl;
  final bool isVeg;
  final double reviews;
}