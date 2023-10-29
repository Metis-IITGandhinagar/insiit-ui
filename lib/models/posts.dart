
class Post {
  String? BusName;
  String? DepartureTime;
  String? Destination;
  String? Source;
  List? Stops;

  Post({this.BusName, this.DepartureTime, this.Destination, this.Source, this.Stops});

  Post.fromJson(Map<String, dynamic> json) {
    BusName = json['BusName'];
    DepartureTime = json['DepartureTime'];
    Destination = json['Destination'];
    Source = json['Source'];
    Stops = json['Stops'];
  }
}
