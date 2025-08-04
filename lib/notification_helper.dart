import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;


class NotificationHelper {
	static final _notification = FlutterLocalNotificationsPlugin();

	static init() async{
		_notification.initialize(const InitializationSettings(
			android: AndroidInitializationSettings('@mipmap/ic_launcher')
		));
		tz.initializeTimeZones();
    await AndroidFlutterLocalNotificationsPlugin().requestExactAlarmsPermission();
	}
	static scheduledNotification(String title, String body, String dateTime) async {
		var androidDetails = AndroidNotificationDetails(
			'reminder',
			'Reminders',
			importance: Importance.max,
			priority: Priority.high
		);
		var notificationDetails = NotificationDetails(android: androidDetails);
		tz.TZDateTime tzDateTime = tz.TZDateTime.from(DateTime.parse(dateTime), tz.local);
		print(tzDateTime);
		await _notification.zonedSchedule(

			0, title, body, tzDateTime.subtract(Duration(minutes: 15)), notificationDetails, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
		);
	}
}
