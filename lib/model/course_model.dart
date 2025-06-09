//This model is based on the course data structure of Naveen Pal API.
class Course {
  final String code;
  final String name;
  final double credits;

  Course({
    required this.code,
    required this.name,
    required this.credits,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      code: json['code'] as String,
      name: json['name'] as String,
      credits: (json['credits'] as num).toDouble(),
    );
  }
}
