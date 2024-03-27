class Events {
  int? id;
  String? name;
  String? location;
  String? date;
  String? time;
  String? image;
  String? description;

  Events({this.id, this.name, this.location, this.date, this.time, this.image, this.description});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['event_name'];
    location = json['location'];
    date = json['date'];
    time = json['start_time'];
    image = json['poster_image_url'];
    description = json['description'];
  }
}
