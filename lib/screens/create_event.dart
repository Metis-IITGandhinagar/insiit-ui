import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:insiit/constants.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key, required this.user});
  final User user;

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  String eventName = "";
  String location = "";
  String description = "";
  String? filePath;
  DateTime? date;
  TimeOfDay? startTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const Text("h"), title: const Text("Create new event")),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              InkWell(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.pickFiles(type: FileType.image);
                    if (result != null) {
                      setState(() {
                        filePath = result.paths.first!;
                      });
                    }
                  },
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: filePath == null
                          ? const Icon(Icons.broken_image)
                          : Image.file((File(filePath!))))),
              TextField(
                  decoration: const InputDecoration(labelText: "Event Name"),
                  onChanged: (text) {
                    setState(() {
                      eventName = text;
                    });
                  }),
              TextField(
                  decoration:
                      const InputDecoration(labelText: "Event Location"),
                  onChanged: (text) {
                    setState(() {
                      location = text;
                    });
                  }),
              TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration:
                      const InputDecoration(labelText: "Event description"),
                  onChanged: (text) {
                    setState(() {
                      description = text;
                    });
                  }),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("By ${widget.user.displayName}")]),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2027));
                        setState(() {
                          date = pickedDate;
                        });
                      },
                      icon: const Icon(Icons.calendar_month)),
                  Text(date == null
                      ? "Date"
                      : "${date!.day}-${date!.month}-${date!.year}")
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        final TimeOfDay? pickedDate = await showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 0, minute: 0));
                        setState(() {
                          startTime = pickedDate;
                        });
                      },
                      icon: const Icon(Icons.access_time)),
                  Text(startTime == null
                      ? "State time"
                      : "${startTime!.hour}:${startTime!.minute}")
                ],
              ),
              FilledButton(
                  onPressed: () async {
                    try {
                      List<int> imageBytes =
                          await File(filePath!).readAsBytes();

                      String base64Image = base64Encode(imageBytes);
                      final response = await http.post(
                          Uri.parse("$API_BASE_URL/events?image_bytes=true"),
                          headers: {
                            "x-api-key": "metis-at-insiit",
                            "Content-Type": "application/json"
                          },
                          body: jsonEncode(<String, dynamic>{
                            "event_name": eventName,
                            "location": location,
                            "date": date.toString(),
                            "start_time": startTime.toString(),
                            "base64Image": base64Image,
                            "description": description,
                            "added_by": widget.user.displayName
                          }));
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        print("Succeeded: ${response.body}");
                      } else {
                        print("Request returned a failure: ${response.body}");
                      }
                    } catch (e) {
                      print("Error: $e");
                    }
                  },
                  child: const Text("Submit"))
            ])));
  }
}
