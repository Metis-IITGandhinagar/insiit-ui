import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TLBookingPage extends StatefulWidget {
  const TLBookingPage({super.key});

  @override
  State<TLBookingPage> createState() => _TLBookingPageState();
}

class _TLBookingPageState extends State<TLBookingPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController machineController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   Future<void> submitForm() async {
    final String apiUrl = 'http://localhost:3000/proceed_form';

    final Map<String, dynamic> formData = {
      "user": nameController.text,
      "email": emailController.text,
      "contact": mobileController.text,
      "machine": machineController.text,
      "utcStartTime": startTimeController.text,
      "utcEndTime": endTimeController.text,
      "info": descriptionController.text,
      "status": statusController.text,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: formData,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Form submitted successfully"),
      ));
      // Form submission successfully
      print("Form submitted successfully");
      print(response.body); // You can process the response data here
    } else {
      // Form submission failed
      print("Form submission failed");
    }
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Form Submission"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  
                    controller: nameController,
                    decoration: InputDecoration(icon: Icon(Icons.person_2_outlined),
                        border: OutlineInputBorder(), labelText: 'Name')),
                SizedBox(height: 15,),
                 TextField(
                  
                    controller: emailController,
                    decoration: InputDecoration(icon: Icon(Icons.email_outlined),border: OutlineInputBorder(), labelText: 'Email')),
                SizedBox(height: 15,),
                 TextField(
                  
                    controller: mobileController,
                    decoration: InputDecoration(icon: Icon(Icons.phone),border: OutlineInputBorder(), labelText: 'Mobile')),
               SizedBox(height: 15,),
                 TextField(
                  
                    controller: machineController,
                    decoration: InputDecoration(icon: Icon(Icons.precision_manufacturing_sharp),border: OutlineInputBorder(), labelText: 'Machine')),
                SizedBox(height: 15,),
                 TextField(
                  
                    controller: startTimeController,
                    decoration: InputDecoration(icon: Icon(Icons.av_timer_outlined),border: OutlineInputBorder(), labelText: 'Start Time')),
                SizedBox(height: 15,),
                 TextField(
                  
                    controller: endTimeController,
                    decoration: InputDecoration(icon: Icon(Icons.av_timer_outlined),border: OutlineInputBorder(), labelText: 'End Time')),
                SizedBox(height: 15,),
                 TextField(
                  
                    controller: descriptionController,
                    decoration: InputDecoration(icon: Icon(Icons.info_outline),border: OutlineInputBorder(), labelText: 'Description')),
                SizedBox(height: 15,),
                 TextField(
                  
                    controller: statusController,
                    decoration: InputDecoration(icon: Icon(Icons.notes_outlined),border: OutlineInputBorder(), labelText: 'Status')),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: FilledButton.icon(
                    
                    icon: Icon(Icons.done_outline),
                    label: Text("Submit Form"),
                    onPressed: submitForm,
                               
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}