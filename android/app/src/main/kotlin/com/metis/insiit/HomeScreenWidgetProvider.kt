package com.metis.insiit

import com.example.insiit.R

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.BitmapFactory
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import java.io.File

class HomeScreenWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
                // Get the image path saved by Flutter
                val imageName = widgetData.getString("qr_image", null)
                if (imageName != null) {
                    val imageFile = File(imageName)
                    if (imageFile.exists()) {
                        val bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
                        setImageViewBitmap(R.id.widget_image, bitmap)
                    }
                }
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
