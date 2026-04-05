import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String localApiUrl =
    'http://10.0.138.244:3000/api/fcmverify'; // API endpoint to send FCM token
const String apiUrl =
    'https://insiit-backend-node.vercel.app/api/fcmverify'; // API endpoint to send FCM token
const String fcmVerifyKey = 'fcmverify';

class MessagingService {
  static String? fcmToken;

  static final MessagingService _instance = MessagingService._internal();

  factory MessagingService() => _instance;

  MessagingService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // Moved _checkFcmVerify outside init to be a class method
  Future<void> _checkFcmVerify(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(fcmVerifyKey)) {
      debugPrint('FCM token not verified yet. Sending to API.');
      await _sendDataToApi(context);
    } else {
      debugPrint('FCM token already marked as verified in SharedPreferences.');
    }
  }

  Future<void> init(BuildContext context) async {
    // Requesting permission for notifications
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
        'User granted notifications permission: ${settings.authorizationStatus}');

    // Retrieving the FCM token
    try {
      fcmToken = await _fcm.getToken();
      print('fcmToken: $fcmToken');

      // Call _checkFcmVerify after retrieving the token
      if (fcmToken != null) {
        await _checkFcmVerify(context);
      } else {
        debugPrint('FCM token is null. Cannot send to API.');
      }
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }

    // Handling background messages using the specified handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listening for incoming messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.notification!.title.toString()}');

      if (message.notification != null) {
        if (message.notification!.title != null &&
            message.notification!.body != null) {
          final notificationData = message.data;
          final screen = notificationData['screen'];

          // Showing an alert dialog when a notification is received (Foreground state)
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  title: Text(message.notification!.title!),
                  content: Text(message.notification!.body!),
                  actions: [
                    if (notificationData.containsKey('screen'))
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          Navigator.of(context).pushNamed(screen);
                        },
                        child: const Text('Open Screen'),
                      ),
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      child: const Text('Dismiss'),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }
    });

    // Handling the initial message received when the app is launched from dead (killed state)
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(context, message);
      }
    });

    // Handling a notification click event when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          'onMessageOpenedApp: ${message.notification!.title.toString()}');
      _handleNotificationClick(context, message);
    });

    // Add handling for FCM token refresh
    _fcm.onTokenRefresh.listen((newToken) async {
      fcmToken = newToken;
      debugPrint('FCM token refreshed: $newToken');
      // When token refreshes, send it to your API
      await _sendDataToApi(context);
    });
  }

  // Handling a notification click event by navigating to the specified screen
  void _handleNotificationClick(BuildContext context, RemoteMessage message) {
    final notificationData = message.data;

    if (notificationData.containsKey('screen')) {
      final screen = notificationData['screen'];
      Navigator.of(context).pushNamed(screen);
    }
  }

  // Send data to API and store in shared preferences if successful
  Future<void> _sendDataToApi(BuildContext context) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      debugPrint('No user is currently signed in. Cannot send FCM data.');
      return;
    }
    if (fcmToken == null) {
      debugPrint('FCM token is null. Cannot send FCM data.');
      return;
    }

    final name = firebaseUser.displayName;
    final email = firebaseUser.email;

    final Map<String, String> data = {
      'name': name ?? '',
      'email': email ?? '',
      'fcmToken': fcmToken!, // fcmToken is checked for null above
    };
    final String jsonData = jsonEncode(data);

    try {
      var response = await http.post(
        Uri.parse(localApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );
      if (!(response.statusCode == 201 || response.statusCode == 200)) {
        response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonData,
        );
      }

      if (response.statusCode == 201 || response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        // Store a representation of the sent data or a simple flag
        // Storing jsonData might be large; consider storing a hash or timestamp if space is a concern
        await prefs.setString(fcmVerifyKey,
            jsonData); // Or simply prefs.setBool(fcmVerifyKey, true);
        print(
            'Data sent to API and verification status stored in shared preferences.');
      } else {
        print(
            'Failed to send data to API. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error sending data to API: $e');
    }
  }
}

// Handler for background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
  if (message.notification != null) {
    debugPrint(
        'Background Message Notification Title: ${message.notification!.title}');
    debugPrint(
        'Background Message Notification Body: ${message.notification!.body}');
  }
}
