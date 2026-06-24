import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() async {
    _notification.initialize(
        settings: const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher')));
    tz.initializeTimeZones();
    await AndroidFlutterLocalNotificationsPlugin()
        .requestExactAlarmsPermission();
  }

  static scheduledNotification(
      String title, String body, String dateTime) async {
    var androidDetails = AndroidNotificationDetails('reminder', 'Reminders',
        importance: Importance.max, priority: Priority.high);
    var notificationDetails = NotificationDetails(android: androidDetails);
    tz.TZDateTime tzDateTime =
        tz.TZDateTime.from(DateTime.parse(dateTime), tz.local);
    print(tzDateTime);
    await _notification.zonedSchedule(
        id: 0,
        title: title,
        body: body,
        // TODO: dateTime should be used here
        scheduledDate: tzDateTime.subtract(const Duration(seconds: 5)),
        notificationDetails: notificationDetails,
        // uiLocalNotificationDateInterpretation:
        //     UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }
}
