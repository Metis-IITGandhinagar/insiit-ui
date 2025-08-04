import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import '../notification_helper.dart';
import '../authentication/login.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.date, required this.time});
  final String date;
  final String time;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

enum DataState { loading, loaded, failed }

class _DetailsPageState extends State<DetailsPage> {
  //bool isInfoLoaded = false;
  //String userName = "";
  //String userEmail = "";
  String userPhoneNumber = "";
  late Future<Map<String, dynamic>?> userFuture;
  DataState dataState = DataState.loading;


  @override
  void initState() {
    super.initState();
    userFuture = fetchData();
  }

  Future<Map<String, dynamic>?> fetchData() async {
    final firebaseAuthInstance = FirebaseAuth.instance;
    final currentUser = await firebaseAuthInstance.currentUser;
    if (currentUser != null && currentUser.isAnonymous == false) {
    print(currentUser);
      return <String, dynamic>{
        "userName": currentUser.displayName!,
        "userEmail": currentUser.email!,
      };
    } else {
    	Fluttertoast.showToast(
		msg: "You need to log in!"
	);
	Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
	return null;
    }
  }

  Future<void> storeHaircutBooking() async {
    final shared_preferences_storage = await SharedPreferences.getInstance();
    String? haircut_data_string =
        shared_preferences_storage.getString('haircut-data');
    if (haircut_data_string != null) {
      final fetched_haircut_data = jsonDecode(haircut_data_string);
      fetched_haircut_data
          .add(<String, dynamic>{"date": widget.date, "time": widget.time});
      await shared_preferences_storage.setString(
          'haircut-data', jsonEncode(fetched_haircut_data));
    } else {
      print("Data not found");
    }
  }

  @override
  Widget build(BuildContext build) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.data == null){
	    return CircularProgressIndicator();
	  } else {
            final userName = snapshot.data!["userName"];
            final userEmail = snapshot.data!["userEmail"];
            return Scaffold(
                appBar: AppBar(title: Text("Details")),
                body: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Date: ${widget.date}"),
                          Text("Time: ${widget.time}"),
                          Divider(),
                          Text("Name: ${userName}"),
                          Text("Email: ${userEmail}"),
                          Divider(),
                          TextField(
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                userPhoneNumber = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Phone Number",
                            ),
                            maxLength: 10,
                            maxLines: 1,
                          ),
                          ElevatedButton(
                              child: Text("Submit"),
                              onPressed: () async {
                                // Add this function
                                // submitDetails();
				try {
                                final firebaseAuthInstance =
                                    FirebaseAuth.instance;
                                final currentUser =
                                    await firebaseAuthInstance.currentUser;
                                if (currentUser != null) {
                                  final uid = currentUser!.uid;
				  print(userName + userEmail);
                                  Response response = await post(
                                      Uri.parse(
                                          "http://10.0.2.2:3000/api/book-haircut-appointment"),
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                            'Auth': 'Bearer ${uid}'
                                      },
                                      body: jsonEncode(<String, dynamic>{
                                        'userdisplayname': userName,
                                        'useremail': userEmail,
                                        'date': widget.date,
                                        'time': widget.time,
                                        'userphonenumber': userPhoneNumber
                                      }));
                                  print(response.statusCode);
                                  if (response.statusCode == 200) {
				    print("H");
                                    await storeHaircutBooking();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (centext) => DonePage(
                                                success:
							true,
						date: 
							widget.date,
						time:
							widget.time,

						    )));
                                  } else {
				    print("F");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (centext) =>
                                                DonePage(success: false,
						date: 
							widget.date,
						time:
							widget.time

						)));
                                  }
                                }
			      } catch(e) {

				Fluttertoast.showToast(
					msg: "Failed to make the appointment"
				);
			      	
			        }
                              }),
                        ])));
          }
        });
  }
}
class DonePage extends StatelessWidget {
  const DonePage({
    super.key,
    required this.success,
    required this.date,
    required this.time,
  });

  final bool success;
  final String date;
  final String time;

  Future<void> _addReminder(BuildContext context) async {
  	NotificationHelper.init();
	NotificationHelper.scheduledNotification('Haircut Reminder', 'You have an haircut scheduled for ${time}', '${date} ${time}');
  }

  @override
  Widget build(BuildContext context) {
    if (success == true) {
      return Scaffold(
        appBar: AppBar(title: Text("Done")),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Booking Successful!"),
              Text("Date: $date"),
              Text("Time: $time"),
              Divider(),
              ElevatedButton(
                onPressed: () => _addReminder(context),
                child: Text("Save Event"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Booking failed")),
      body: Center(
        child: Padding(padding: EdgeInsets.all(8.0), child: Text(
          "Booking failed for some reason. Please contact the Metis team",
        )),
      ),
    );
  }
}
// class DonePage extends StatelessWidget {
//   const DonePage({super.key, required this.success, required this.date, required this.time});
//   final bool success;
//   final String date;
//   final String time;


//   void _addReminder() {
//   	final startTime = DateTime.parse(date + " " + time + ":00");
  	
// 	final Event event = Event(
// 		title: 'Event title',
// 		description: 'Event description',
// 		location: 'Event location',
// 		startDate: startTime,
// 		endDate: startTime.add(const Duration(minutes: 30)),
// 	);
// 	print(event.title.toString());
// 	Add2Calendar.addEvent2Cal(event);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (success == true) {
//     	return Scaffold(
// 		appBar: AppBar(title: Text("Done")),
// 		body: Padding(
// 			padding: EdgeInsets.all(16.0),
// 			child: Column(
// 				children: [
// 					Text("Booking Successfull!"),
// 					Text("Date: ${date}"),
// 					Text("Time: ${time}"),
// 					Divider(),
// 					ElevatedButton(
// 						onPressed: () {_addReminder();},
// 						child: Text("Save Event")
// 					)
// 				]
// 			)
// 		)
// 	);
//     }

//     return Scaffold(
//         appBar: AppBar(title: Text("Booking failed")),
// 	body: Column(
// 		children: [
// 			Text("Booking failed for some reason. Please contacet Metis team")
// 		]
// 	)
//     );
//   }
// }
