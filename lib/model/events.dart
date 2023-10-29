class Event {
  String? date;
  int? id;
  String? name;
  String? image;


  Event(
      {
    this.date,
        this.id,
      this.name,
      this.image
  
  });

  Event.fromJson(Map<String, dynamic> json) {
     date = json['date'];
    id = json['id'];
    name = json['name'];
    image = json['image'];
  
 
  }
}
