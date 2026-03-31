import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class HostelCleaningScreen extends StatefulWidget {
  const HostelCleaningScreen({super.key});
  @override
  State<HostelCleaningScreen> createState() => _HostelCleaningScreenState();
}

class _HostelCleaningScreenState extends State<HostelCleaningScreen> {
  TextEditingController hostelNameController = TextEditingController();
  TextEditingController roomNoController = TextEditingController();
  Floor? _floor;
  RoomStatus? _roomStatus;
  Hostel? _hostel;
  static final List<DropdownMenuEntry<Hostel>> hostelEntries =
      UnmodifiableListView<DropdownMenuEntry<Hostel>>(Hostel.values.map((e) {
    return DropdownMenuEntry<Hostel>(value: e, label: e.name);
  }));
  late SharedPreferences _prefs;
  DateTime today = DateTime.now();
  TimeOfDay outTime = TimeOfDay.now();
  TimeOfDay inTime = TimeOfDay.fromDateTime(
      DateTime.now().subtract(const Duration(minutes: 15)));

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefs = prefs;
      roomNoController.text = _prefs.getString("Room No.") ?? "";
      for (final floor in Floor.values) {
        if (_prefs.getString("Floor") == floor.name) {
          _floor = floor;
          break;
        }
      }
      for (final hostel in Hostel.values) {
        if (_prefs.getString("Hostel Name") == hostel.name) {
          _hostel = hostel;
          break;
        }
      }
      for (final roomStatus in RoomStatus.values) {
        if (_prefs.getString("Room Status") == roomStatus.name) {
          _roomStatus = roomStatus;
          break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> _selectInTime() async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    setState(() {
      inTime = pickedTime ?? inTime;
    });
  }

  Future<void> _selectOutTime() async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    setState(() {
      outTime = pickedTime ?? outTime;
    });
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    setState(() {
      today = pickedDate ?? today;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Hostel Cleaning Form")),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      Row(children: [
                        Text('${today.day}/${today.month}/${today.year}'),
                        IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: _selectDate)
                      ]),
                      const SizedBox(height: 20),
                      const Text("Out Time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      Row(children: [
                        Text(
                            '${outTime.hour}:${outTime.minute} ${outTime.period == DayPeriod.am ? "AM" : "PM"}'),
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: _selectOutTime)
                      ]),
                      const SizedBox(height: 20),
                      const Text("In Time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      Row(children: [
                        Text(
                            '${inTime.hour}:${inTime.minute} ${inTime.period == DayPeriod.am ? "AM" : "PM"}'),
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: _selectInTime)
                      ]),
                      const SizedBox(height: 20),
                      DropdownMenu<Hostel>(
                          initialSelection: _hostel,
                          onSelected: (Hostel? value) {
                            setState(() {
                              _hostel = value;
                            });
                            _prefs.setString("Hostel Name", value?.name ?? "");
                          },
                          dropdownMenuEntries: hostelEntries),
                      const SizedBox(height: 20),
                      TextField(
                          controller: roomNoController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Room No.'),
                          onChanged: (String value) {
                            _prefs.setString("Room No.", value.toString());
                          }),
                      const SizedBox(height: 20),
                      const Text(
                        "Floor",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      RadioGroup<Floor>(
                          groupValue: _floor,
                          onChanged: (Floor? value) {
                            setState(() {
                              _floor = value;
                            });
                            _prefs.setString("Floor", value?.name ?? "");
                          },
                          child: Column(
                              children: Floor.values
                                  .map((e) => ListTile(
                                      title: Text(e.name),
                                      leading: Radio<Floor>(value: e)))
                                  .toList())),
                      const SizedBox(height: 20),
                      const Text("Room Status",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                      RadioGroup<RoomStatus>(
                          groupValue: _roomStatus,
                          onChanged: (RoomStatus? value) {
                            setState(() {
                              _roomStatus = value;
                            });
                            _prefs.setString("Room Status", value?.name ?? "");
                          },
                          child: Column(
                              children: RoomStatus.values
                                  .map((e) => ListTile(
                                      title: Text(e.name),
                                      leading: Radio<RoomStatus>(value: e)))
                                  .toList())),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledButton(
                                child: const Text("Submit"),
                                onPressed: () async {
                                  final hostel = _hostel?.name ?? "";
                                  final Uri url = Uri.parse(
                                          "https://docs.google.com/forms/d/e/1FAIpQLScEnJqAq920h773mxPYtVff5mFQcwi-wi7IqKWFXlIVGNWwbg//viewform")
                                      .replace(queryParameters: {
                                    "entry.323685715": hostel,
                                    "entry.239223788_hour":
                                        inTime.hour.toString(),
                                    "entry.239223788_minute":
                                        inTime.minute.toString(),
                                    "entry.954956185_hour":
                                        outTime.hour.toString(),
                                    "entry.954956185_minute":
                                        outTime.minute.toString(),
                                    "entry.56428407_year":
                                        today.year.toString(),
                                    "entry.56428407_month":
                                        today.month.toString(),
                                    "entry.56428407_day": today.day.toString(),
                                    "entry.1539074242": roomNoController.text,
                                    "entry.823196748": _floor?.name ?? "",
                                    "entry.1708784547": _roomStatus?.name ?? "",
                                  });
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                })
                          ])
                    ]))));
  }
}

enum Floor {
  groundFloor("Ground Floor"),
  firstFloor("First Floor"),
  secondFloor("Second Floor"),
  thirdFloor("Third Floor");

  final String name;
  const Floor(this.name);
}

enum RoomStatus {
  clean("Clean"),
  notClean("Not Clean"),
  selfCleaning("Self Cleaning");

  final String name;
  const RoomStatus(this.name);
}

enum Hostel {
  aibaan("Aibaan"),
  beauki("Beauki"),
  chimair("Chimair"),
  duven("Duven"),
  emiet("Emiet"),
  firpeal("Firpeal"),
  griwiksh("Griwiksh"),
  hiqom("Hiqom"),
  ijokha("Ijokha"),
  jurqia("Jurqia"),
  kyzeel("Kyzeel"),
  lekhaag("Lekhaag"),
  ;

  final String name;
  const Hostel(this.name);
}
