// import 'package:flutter/material.dart';

// class MessPage extends StatefulWidget {
//   const MessPage({super.key});

//   @override
//   State<MessPage> createState() => _MessPageState();
// }

// class _MessPageState extends State<MessPage> {
//   List<String> daysOfWeek = [
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday',
//     'Friday',
//     'Saturday',
//     'Sunday'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 50.0,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: daysOfWeek.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: OutlinedButton(
//                     onPressed: () {
//                       // Add functionality to display respective meals for the selected day
//                     },
//                     child: Text(daysOfWeek[index]),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Card(
//               color: Color.fromARGB(255, 185, 196, 246),
//               child: ExpansionTile(
//                 title: Text("Breakfast"),
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         child: Text("Hello"),
//                       )
//                     ],
//                   )
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:rotating_icon_button/rotating_icon_button.dart';
import 'package:sqflite/sqflite.dart';
import '../../database/mess_db.dart';
import 'package:intl/intl.dart';

class MealsDisplayScreen extends StatefulWidget {
  const MealsDisplayScreen({super.key});

  static const routeName = 'meals-display-screen';

  static const List<String> weekDays = [
    // Intl packages uses monday as starting index.
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  State<MealsDisplayScreen> createState() => _MealsDisplayScreenState();
}

class _MealsDisplayScreenState extends State<MealsDisplayScreen> {
  // bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var day = DateFormat('EEEE').format(DateTime.now());
    return DefaultTabController(
      // key: ,
      initialIndex: MealsDisplayScreen.weekDays.indexOf(
        day,
      ),
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              ...MealsDisplayScreen.weekDays
                  .map((e) => Tab(
                        child: Text(
                          e,
                          style: const TextStyle(
                              fontSize: 17.5, color: Colors.black),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
        body: TabBarView(
          // key: weekDays.,
          children: <Widget>[
            ...MealsDisplayScreen.weekDays.map(
              (e) => ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: 4,
                itemBuilder: (ctx, index) => MessMenuTile(
                  e,
                  index,
                  MealsDisplayScreen.weekDays.indexOf(e),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessMenuTile extends StatefulWidget {
  final String mealName;
  final int index;
  final int weekIndex;
  final mealNameList = ["Breakfast", "Lunch", "Snacks", "Dinner"];
  MessMenuTile(this.mealName, this.index, this.weekIndex, {super.key});

  @override
  State<MessMenuTile> createState() => _MessMenuTileState();
}

class _MessMenuTileState extends State<MessMenuTile> {
  var _expanded = false;

  Future<List> _fetchMenuItems(int weekDay, String mealName) async {
    // var menu =  await MessDatabase.getData("menu");
    Database db = await MessDatabase.database();
    // print(MealsDisplayScreen.weekDays[weekDay]);
    List<Map<String, Object?>> list = await db.rawQuery(
        'SELECT $mealName FROM menu WHERE dayName = "${MealsDisplayScreen.weekDays[weekDay]}"');
    // print(list);
    List<String> messItem =
        list[0][mealName.toLowerCase()].toString().split("_");
    // print(messItem);
    return messItem;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).canvasColor,
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.mealNameList[widget.index],
              style: GoogleFonts.roboto(),
            ),
            // enabled: true,
            onTap: () => setState(() {
              _expanded = !_expanded;
            }),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_more : Icons.expand_less),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            FutureBuilder(
              future: _fetchMenuItems(
                  widget.weekIndex, widget.mealNameList[widget.index]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final data = snapshot.data as List;

                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (data[index].toString().isEmpty ||
                          data[index].toString().length == 1) {
                        return ListTile(
                          title: Text(
                            "Salt",
                            style: GoogleFonts.lato(),
                          ),
                        );
                      } else {
                        return ListTile(
                          title: Text(
                            data[index],
                            style: GoogleFonts.lato(),
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          // const ElevatedButton(onPressed: null, child: Text("Raise Issue?"),),
        ],
      ),
    );
  }
}
