import 'package:flutter/material.dart';

class ImportantContacts extends StatefulWidget {
  const ImportantContacts({Key? key}) : super(key: key);

  @override
  State<ImportantContacts> createState() => ImportantContactsState();
}

class ImportantContactsState extends State<ImportantContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Medical Facilities Info"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.abc_outlined),
            Text(
              "Medical Facility",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Location: First floor of the Central Arcade, IITGN Campus"),
            Text("Contact: 1116 (VOIP)"),
            Text("Emergency Contact: 7069795000"),
            SizedBox(height: 20),
            Text(
              "Monday To Friday",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DataTable(
              clipBehavior: Clip.none,
              dataRowMinHeight: 30.0,
              columns: [
                DataColumn(label: Text("Doctor")),
                DataColumn(label: Text("Timing")),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("Dr. K V Mehta")),
                  DataCell(Text("09:30 AM - 11:30 AM")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Dr. Deepa Shah")),
                  DataCell(Text("01:30 PM - 04:30 PM")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Dr. Bhavesh Panchal")),
                  DataCell(Text("04:00 PM - 06:00 PM")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Dr. Mira Butani (Gynaecologist)")),
                  DataCell(Text("01:30 PM - 02:30 PM\n(Monday & Thursday)")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Dr. Arvind Chauhan (Physiotherapy)")),
                  DataCell(Text("05:30 PM - 07:30 PM")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Mrs. Priyam Sharma Khanna (Dietician)")),
                  DataCell(Text("02:00 PM - 04:00 PM\n(Tuesday & Friday)")),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
