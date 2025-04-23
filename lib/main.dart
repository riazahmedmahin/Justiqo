import 'package:flutter/material.dart';
import 'package:layer/app.dart';
import 'package:layer/data/model/model.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz_data;

// Initialize the notification plugin
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize timezone data
  tz_data.initializeTimeZones();
  //final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  //tz.setLocalLocation(tz.getLocation(timeZoneName));
  
  // Initialize timezone data for scheduled notifications
  // tz_data.initializeTimeZones();
  
  // // Initialize notifications
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  
  // const InitializationSettings initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  // );
  
  // await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
  //     // Handle notification tap
  //   },
  // );
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LawyerProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const LayerAdvisor(),
    ),
  );
}

