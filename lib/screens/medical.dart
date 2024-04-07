import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicalFacilityPage extends StatelessWidget {
  const MedicalFacilityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Facilities Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 1,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle location navigation
                        },
                        child: Text(
                          'First floor of the Central Arcade, IITGN Campus',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Contact:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '1116 (VOIP)',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Emergency:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '7069795000',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.call), 
                            onPressed: () {
                              launch('tel://7069795000');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 1,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monday To Friday',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Doctor')),
                            DataColumn(label: Text('Timings')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('Dr. K V Mehta')),
                              DataCell(Text('09:30 hrs to 11:30 hrs')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Dr. Deepa Shah')),
                              DataCell(Text('13:30 hrs to 16:30 hrs')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Dr. Bhavesh Panchal')),
                              DataCell(Text('16:00 hrs to 18:00 hrs')),
                            ]),
                            DataRow(cells: [
                              DataCell(
                                  Text('Dr. Mira Butani \n(Gynaecologist)')),
                              DataCell(Text(
                                  '13:30 hrs to 14:30 hrs\n(Mon & Thurs)')),
                            ]),
                            DataRow(cells: [
                              DataCell(
                                  Text('Dr. Arvind Chauhan \n(Physiotherapy)')),
                              DataCell(Text('17:30 hrs to 19:30 hrs')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  'Mrs. Priyam Sharma Khanna \n(Dietician)')),
                              DataCell(
                                  Text('14:00 hrs to 16:00 hrs\n(Tue & Fri)')),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 1,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saturday',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Doctor')),
                            DataColumn(label: Text('Timings')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('Dr. K V Mehta')),
                              DataCell(Text('09:30 hrs to 11:30 hrs')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Dr. Bhavesh Panchal')),
                              DataCell(Text('13:30 hrs to 15:30 hrs')),
                            ]),
                            DataRow(cells: [
                              DataCell(
                                  Text('Dr. Arvind Chauhan\n (Physiotherapy)')),
                              DataCell(Text('17:30 hrs to 19:30 hrs')),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
