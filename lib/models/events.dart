class Event {
  String? date;
  String? id;
  String? name;


  Event(
      {
    this.date,
        this.id,
      this.name,
  
  });

  Event.fromJson(Map<String, dynamic> json) {
     date = json['date'];
    id = json['id'];
    name = json['name'];
  
 
  }
}
