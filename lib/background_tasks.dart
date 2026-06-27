import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await updateMenuWidgetLogic();
    return true;
  });
}

Future<void> updateMenuWidgetLogic() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      
      // Load menu from SharedPreferences using the correct key 'cachedMenu'
      if (!prefs.containsKey('cachedMenu')) {
        return;
      }
      
      var rawData = prefs.getString('cachedMenu');
      if (rawData == null) {
        debugPrint("WIDGET DEBUG: rawData is null");
        return;
      }
      
      var data = json.decode(rawData);
      if (data == null || data['mess'] == null) {
        debugPrint("WIDGET DEBUG: data or data['mess'] is null");
        return;
      }

      // Determine current day
      DateTime now = DateTime.now();
      int currentWeekday = now.weekday; // 1 = Monday, 7 = Sunday
      
      // Find today's menu in the list
      List<dynamic> messDays = data['mess'];
      var todayMenu = messDays.firstWhere(
        (day) => day['day'] == currentWeekday, 
        orElse: () => null
      );
      
      if (todayMenu == null) {
        debugPrint("WIDGET DEBUG: todayMenu is null for weekday $currentWeekday. Data: $messDays");
        return;
      }

      String mealTitle = "BREAKFAST";
      String? mealItems = "";
      
      debugPrint("WIDGET DEBUG: Using hour ${now.hour} for meal logic.");

      if (now.hour < 11) {
        mealTitle = "BREAKFAST";
        mealItems = todayMenu['breakfast'];
      } else if (now.hour < 15) {
        mealTitle = "LUNCH";
        mealItems = todayMenu['lunch'];
      } else if (now.hour < 18) {
        mealTitle = "SNACKS";
        mealItems = todayMenu['snacks'];
      } else if (now.hour < 23) {
        mealTitle = "DINNER";
        mealItems = todayMenu['dinner'];
      } else {
        mealTitle = "BREAKFAST";
        mealItems = todayMenu['breakfast'];
      }

      if (mealItems == null || mealItems.isEmpty) {
        mealItems = "Not available";
      }

    // onkar changed START: Use native widget text fields instead of rendering an image
    debugPrint("WIDGET DEBUG: Saving mealTitle: $mealTitle, mealItems: $mealItems");
    await HomeWidget.saveWidgetData<String>('meal_title', mealTitle);
    await HomeWidget.saveWidgetData<String>('meal_items', mealItems);
    debugPrint("WIDGET DEBUG: Calling updateWidget...");
    await HomeWidget.updateWidget(name: 'MenuWidgetProvider', iOSName: 'MenuWidgetProvider');
    debugPrint("WIDGET DEBUG: Successfully requested updateWidget on native side!");
    // onkar changed END

  } catch (e) {
    debugPrint("Background task error: $e");
  }
}
