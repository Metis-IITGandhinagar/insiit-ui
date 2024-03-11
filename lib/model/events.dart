class Events {
  String? date;
  int? id;
  String? name;
  String? image;
  String? location;


  Events(
      {
    this.date,
        this.id,
      this.name,
      this.image,
      this.location
  
  });

  Events.fromJson(Map<String, dynamic> json) {
     date = json['date'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
    location = json['location'];
  
 
  }
}