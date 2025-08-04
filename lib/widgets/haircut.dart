import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import './haircutBooking.dart';
import 'dart:convert';

class HaircutBookingPage extends StatefulWidget {
	
	@override
	State<HaircutBookingPage> createState() => _HaircutBookingPageState();
}


class _HaircutBookingPageState extends State<HaircutBookingPage> {


	bool is_data_fetched = false;
	List<dynamic> haircut_data = [];

	Future<void> fetchData() async {
		final shared_preferences_storage = await SharedPreferences.getInstance();
		String? haircut_data_string = shared_preferences_storage.getString('haircut-data');
		if (haircut_data_string != null) {
			final fetched_haircut_data = jsonDecode(haircut_data_string);
			setState(() {
				haircut_data = fetched_haircut_data;
				is_data_fetched = true;
			});
		} else {
			await shared_preferences_storage.setString('haircut-data', jsonEncode([]));
			setState(() {
				is_data_fetched = true;
			});
		}
	}
				
	@override
	void initState() {
		super.initState();
		fetchData();
	}

	

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text("Haircut Bookings")),
			body: 
				!is_data_fetched ? Center(child: CircularProgressIndicator()) : 

				Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [SingleChildScrollView(
						
						child: Column(
							mainAxisAlignment: MainAxisAlignment.start,
							crossAxisAlignment: CrossAxisAlignment.center,
							children: [
								ElevatedButton(
									child: Text("Make a new appointment"),
									onPressed: () async{
									try {
										
										http.Response response = await http.get(Uri.parse("http://10.0.2.2:3000/api/haircut-dates"));
										if (response.body != null) {
											final haircutDates = jsonDecode(response.body)["data"]["dates"].map((date) {
												return DateTime.parse(date);
											}).toList();
											if (haircutDates.isEmpty) {
												Fluttertoast.showToast(
													msg: "No dates available",
												);
												return ;
											}
											final DateTime? pickedDate = await showDatePicker(

												context: context,
												firstDate: DateTime(2000),
												lastDate: DateTime(2027),
												selectableDayPredicate: (date) {
													return haircutDates.contains(date) ? true : false;
												}
											);
											if(pickedDate == null) {
												Fluttertoast.showToast(
													msg: "Please select the date again"
												);
												
											} else {
												final pickedDateIndex = haircutDates.indexOf(pickedDate);
												Navigator.push(
													context,
													MaterialPageRoute(
														builder: (context) => TimeSlotPage(initialDateIndex: pickedDateIndex)),
												);
											}
										}
										} catch(e) {
											Fluttertoast.showToast(
												msg: "Failed to connect to the server",
											);
										}


									},
								),
								...haircut_data.map((booking) {

								return Card(
									child: InkWell(
										borderRadius: const BorderRadius.all(Radius.circular(16.0)),
										splashColor: const Color.fromARGB(103, 159, 111, 255),
										child: Container(
											child:
												Padding(
													padding: EdgeInsets.all(16.0),
													child: Column(
														mainAxisAlignment: MainAxisAlignment.start,
														children: [
															Text("Date: ${booking['date']}"), 
															Text("Time: ${booking['time']}")
														]
													),
												),
												width: 380, height: 80
										)
												
												
									)

								);
								})
							]
						)
					)]
				)
		);
	}

}











