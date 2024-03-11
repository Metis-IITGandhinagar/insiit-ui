import 'package:flutter/material.dart';
import '../model/events.dart';

class EventDetailsPage extends StatefulWidget {
  final Events? event;

  EventDetailsPage({required this.event});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.event?.name ?? 'Event Name Not Available'),
              background: Image.network(
                widget.event?.image ?? "Image Unavailabe",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // Add content here
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text( 
                  '''Event Description: \n\n 📍Location: ${widget.event?.location ?? 'No location'} \n \n
An event description is a written piece that provides an overview of an event. It should address the five essential questions: who, what, when, where, and why
Here are some examples of event descriptions
Fighting For a Better Tomorrow: Virtual Webinar Series:
Date: April 20, 3 pm PT
Where: Streamed live on Zoom
Cost: Free
The next outstanding show is Monday March 23rd at 8pm:
The Comedy Cabaret offers a Laffy Raffy Raffle
Comets are the most primitive building blocks of our solar system:
Retrieving a sample from the surface of comet 67P can provide unparalleled knowledge about ...
If your event is a 10K to raise money for the high school sports teams, i Better Tomorrow: Virtual Webinar Series:
Date: April 20, 3 pm PT
Where: Streamed live on Zoom
Cost: Free
The next outstanding show is Monday March 23rd at 8pm:
The Comedy Cabaret offers a Laffy Raffy Raffle
Comets are the most primitive building blocks of our solar system:
Retrieving a sample from the surface of comet 67P can provide unparalleled knowledge about ...
If your event is a 10K to raise money for the high school sports teams, i Better Tomorrow: Virtual Webinar Series:
Date: April 20, 3 pm PT
Where: Streamed live on Zoom
Cost: Free
The next outstanding show is Monday March 23rd at 8pm:
The Comedy Cabaret offers a Laffy Raffy Raffle
Comets are the most primitive building blocks of our solar system:
Retrieving a sample from the surface of comet 67P can provide unparalleled knowledge about ...
If your event is a 10K to raise money for the high school sports teams, it may include a runner's bag with water and snacks, a t-shirt and Band Aids''',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              // Add more content widgets as needed
            ]),
          ),
        ],
      ),
    );
  }
}