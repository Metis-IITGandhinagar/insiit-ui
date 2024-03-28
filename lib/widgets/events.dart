import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/events.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({Key? key});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  late Future<List<Events>> eventsFuture;

  @override
  void initState() {
    super.initState();
    eventsFuture = getPosts();
  }

  Future<List<Events>> getPosts() async {
    var url = Uri.parse("https://insiit-backend-node.vercel.app/api/events");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Events.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events Calendar"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Events>>(
        future: eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<Events> events = snapshot.data!;
            return EventCalendar(
              calendarType: CalendarType.GREGORIAN,
              calendarLanguage: 'en',
              headerOptions: HeaderOptions(
                calendarIconColor: Theme.of(context).colorScheme.onSecondaryContainer,
                navigationColor: Theme.of(context).colorScheme.onSecondaryContainer,
                headerTextColor: Theme.of(context).colorScheme.onSecondaryContainer,
                resetDateColor: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              dayOptions: DayOptions(
                showWeekDay: true,
                disableDaysBeforeNow: true,
                disableFadeEffect: true,
                weekDaySelectedColor: Theme.of(context).colorScheme.onSecondaryContainer,
                unselectedTextColor: Theme.of(context).colorScheme.onSecondaryContainer,
                weekDayUnselectedColor: Theme.of(context).colorScheme.onTertiaryContainer,
                selectedBackgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                selectedTextColor: Theme.of(context).colorScheme.onSecondaryContainer,
                eventCounterColor: Colors.deepPurple,
              ),
              showLoadingForEvent: true,
              calendarOptions: CalendarOptions(
                headerMonthBackColor: Theme.of(context).colorScheme.secondaryContainer,
                headerMonthShadowColor: Theme.of(context).colorScheme.secondaryContainer,
                bottomSheetBackColor: Theme.of(context).colorScheme.secondaryContainer,
                toggleViewType: true,
                viewType: ViewType.DAILY,
              ),
              eventOptions: EventOptions(
                emptyIcon: Icons.event_busy_outlined,
                emptyTextColor: Theme.of(context).colorScheme.secondary,
                emptyIconColor: Theme.of(context).colorScheme.secondary,
                emptyText: "No Events Found",
              ),
              events: events.map((event) {
                return Event(
                  child: ListTile(
                    leading: Icon(Icons.event_outlined),
                    title: Text(event.name ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(event.time ?? "", style: TextStyle(fontSize: 16)),
                  ),
                  dateTime: CalendarDateTime(
                    year: int.parse(event.date?.substring(0, 4) ?? "2023"),
                    month: int.parse(event.date?.substring(5, 7) ?? "11"),
                    day: int.parse(event.date?.substring(8, 10) ?? "26"),
                    calendarType: CalendarType.GREGORIAN,
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
