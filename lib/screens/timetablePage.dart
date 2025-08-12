import 'package:flutter/material.dart';
import '../model/timetable_entry_model.dart';



enum DataState { loading, loaded, failed }
final days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

class TimetablePage extends StatefulWidget {
	Map<String, List<TimetableEntry>> timetableData = {};
	TimetablePage({ super.key, required this.timetableData });

	@override
	State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {



	@override
	Widget build(BuildContext context) {
		print(widget.timetableData);
			try {
				final todayDayIndex = DateTime.now().weekday - 1;
				return DefaultTabController(
					initialIndex: todayDayIndex < 5 ? todayDayIndex : 0,
					length: 5,
					child: Scaffold(
						appBar: AppBar(
							title: Text("Timetable"),
							bottom: TabBar(
								isScrollable: true,
								tabs: days.map((day) {return Tab(text: day);}).toList(),
							),
						),
						body: TabBarView(
							children: days.map((day) {
									return  widget.timetableData[day.toLowerCase()] != null ? TimetableEntryTile(dayClasses: widget.timetableData[day.toLowerCase()]!) : Center(child: Text("No classes scheduled for ${day}! 🎉"));

								}).toList()
						)
					),
				);
			} catch(e) {
				return Scaffold(body: Center(child: Text("Failed to load your schedule, please try again")));
			}
		
	
	}
}


class TimetableEntryTile extends StatelessWidget {
	final List<TimetableEntry> dayClasses; 
	const TimetableEntryTile({ required this.dayClasses });

	@override
	Widget build(BuildContext context) {
	    return ListView.builder(
	      shrinkWrap: true,
	      physics: const NeverScrollableScrollPhysics(),
	      itemCount: dayClasses.length,
	      itemBuilder: (context, index) {
		final entry = dayClasses[index];
		return Card(
		  elevation: 2,
		  margin: const EdgeInsets.symmetric(
		      vertical: 6, horizontal: 0), 
		  shape:
		      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
		  child: ListTile(
		    contentPadding:
			const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
		    leading: CircleAvatar(
		      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
		      child: Text(
			entry.startTime.split(':')[0],
			style: TextStyle(
			    color: Theme.of(context).colorScheme.primary,
			    fontWeight: FontWeight.bold,
			    fontSize: 18),
		      ),
		    ),
		    title: Text(
		      entry.fullClassDetails,
		      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
		    ),
		    subtitle: Text(
		      'Time: ${entry.startTime} - ${entry.endTime}',
		      style: TextStyle(fontSize: 13),
		    ),
		  ),
		);
	      },
	    );
	}
}

