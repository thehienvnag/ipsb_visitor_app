package com.ipsb.visitor_app

import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin

class Application : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
//        FlutterMain.startInitialization(this);
        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
    }

//    override fun registerWith(registry: PluginRegistry?) {
////        if (!registry!!.hasPlugin("io.flutter.plugins.firebasemessaging")) {
////
////        }
////        if (!registry.hasPlugin("com.dexterous.flutterlocalnotifications")) {
////            FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
////        }
////        GeneratedPluginRegistrant.registerWith(registry);
//        FirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
//    }

    override fun registerWith(registry: PluginRegistry?) {
        val key: String? = FlutterFirebaseMessagingPlugin::class.java.canonicalName
        if (!registry?.hasPlugin(key)!!) {
            FlutterFirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin"));
        }

        if (registry != null) {
            FlutterLocalNotificationPluginRegistrant.registerWith(registry);
        }

//        if (alreadyRegisteredWith(registry)) {
////            Log.d("Local Plugin", "Already Registered");
//            return true
//        }
//        FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"))
////        Log.d("Local Plugin", "Registered");
    }

}