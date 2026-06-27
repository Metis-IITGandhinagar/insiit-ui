// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// onkar changed START: Add home_widget import for home screen widget functionality
import 'package:home_widget/home_widget.dart';
// onkar changed END
class QRDisplay extends StatefulWidget {
  @override
  _QRDisplayState createState() => _QRDisplayState();
}

var email = FirebaseAuth.instance.currentUser!.email ?? "";

class _QRDisplayState extends State<QRDisplay> {
  Future<String> qrDataMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    // String scrapedData = '';
    var scrapedData = prefs.getString('qr_data') ?? '';
    // print(scrapedData);
    return scrapedData;
  }

  // onkar changed START: Make the home widget use real QR data instead of dummy data
  Future<void> _updateHomeWidget() async {
    try {
      var qrData = await qrDataMethod();
      if (qrData.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cannot update widget: No QR data found!')));
        return;
      }

      // 1. Render the real QR code to a dynamic image file to prevent caching
      String? path = await HomeWidget.renderFlutterWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            width: 280.0,
            height: 280.0,
            color: Colors.white,
            alignment: Alignment.center,
            child: QrImageView(
              backgroundColor: Colors.white,
              data: qrData,
              version: QrVersions.auto,
              size: 280.0,
            ),
          ),
        ),
        key: 'qr_image_${DateTime.now().millisecondsSinceEpoch}',
        logicalSize: const Size(280, 280),
      );
      // 2. Update the widget data and trigger update
      if (path != null) {
        await HomeWidget.saveWidgetData<String>('qr_image', path);
        await HomeWidget.updateWidget(
            name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Widget successfully updated with real QR!')));
      }
    } catch (e) {
      debugPrint('Error updating widget: $e');
    }
  }
  // onkar changed END

  // String scrapedData = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    emailController.text = email!;
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var no_data = const Text("data");

    var qrshow = FutureBuilder<String>(
      future: qrDataMethod(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            String qrData = snapshot.data!;
            return Row(
              children: [
                QrImageView(
                  backgroundColor: Colors.white,
                  data: qrData,
                  version: QrVersions.auto,
                  size: 280.0,
                ),
              ],
            );
          } else {
            return const Center(child: Text("Sign In to get QR"));
          }
        } else {
          return const CircularProgressIndicator(); // Or any other loading indicator
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Mess QR Code"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (qrDataMethod() != '') ...[qrshow] else ...[no_data],
            ],
          ),

          Column(
            children: [
              const SizedBox(height: 50),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person_2_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'E-mail ID(IITGN)'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    icon: Icon(Icons.password_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(
                height: 15,
              ),
              FilledButton.icon(
                icon: const Icon(Icons.qr_code),
                onPressed: () {
                  performWebScraping(
                      emailController.text, passwordController.text);
                },
                label: const Text("Refresh your QR"),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width - 50,
                // height: 100,
                decoration: BoxDecoration(

                    // color: Colors.amber[50],
                    border: Border.all(width: 1, color: Colors.green.shade700),
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: const Icon(Icons.security_outlined),
                  iconColor: Colors.green.shade700,
                  title: Text("We do not store your credentials.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green.shade700),
                      textAlign: TextAlign.left),
                ),
              )
            ],
          ),
          // Text(qrDataMethod()?? null),

          // FilledButton.icon(onPressed: () {
          //   performWebScraping();
          // }, icon: Icon(Icons.qr_code), label: Text("Refresh your QR"))
        ]),
      ),
    );
  }

  void performWebScraping(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    var loginUrl = 'http://mess.iitgn.ac.in/phpscripts/authenticate.php';

    var loginData = FormData.fromMap({
      'useremail': email,
      'userpassword': password,
    });
    
    var dio = Dio(BaseOptions(
      responseType: ResponseType.plain,
      followRedirects: false,
      validateStatus: (status) {
        return true;
      },
    )); // some dio configurations
    
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    try {
      var loginresponse = await dio.post(loginUrl, data: loginData);
      print(loginresponse.data);

      if (loginresponse.statusCode == 200 || loginresponse.statusCode == 302) {
        // Get the index.php page with the cookies
        var indexPageResponse = await dio.get('http://mess.iitgn.ac.in/');

        dom.Document doc = parse(indexPageResponse.data);
        var ord = doc.querySelectorAll('span.text-purple');
        
        if (ord.length < 2) {
          // If the span doesn't exist, it means login failed (wrong credentials)
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to refresh QR. Please check your credentials.'),
                backgroundColor: Colors.red,
              )
            );
          }
          return;
        }

        // display the QR information
        var scrapedData = ord[1].text;
        
        setState(() {
          prefs.setString('qr_data', scrapedData);
        });
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('QR Code successfully refreshed!'),
              backgroundColor: Colors.green,
            )
          );
        }

        // onkar changed START: Update the home widget automatically after fetching new data
        await _updateHomeWidget();
        // onkar changed END

      } else {
         if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Server error while logging in.'),
                backgroundColor: Colors.red,
              )
            );
         }
      }
    } catch (e) {
      debugPrint("Network or Scraping Error: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Connect to IITGN SSO to generate QR'),
            backgroundColor: Colors.red,
          )
        );
      }
    }
  }
}
