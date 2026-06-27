package com.metis.insiit

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import com.example.insiit.R
import es.antonborri.home_widget.HomeWidgetPlugin

class MenuWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.menu_widget_layout)
            
            val widgetData = HomeWidgetPlugin.getData(context)
            
            // Read string data passed from Flutter instead of an image path
            val mealTitle = widgetData.getString("meal_title", "MENU")
            val mealItems = widgetData.getString("meal_items", "Loading...")

            views.setTextViewText(R.id.menu_widget_title, mealTitle)
            views.setTextViewText(R.id.menu_widget_items, mealItems)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
