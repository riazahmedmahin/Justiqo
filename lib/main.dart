import 'package:flutter/material.dart';
import 'package:layer/app.dart';
import 'package:layer/core/theme/app_theme.dart';
import 'package:layer/data/model/model.dart';
import 'package:layer/presentation/screens/AIBot/aibot.dart';
import 'package:layer/presentation/screens/auth/LogInScreen.dart';
import 'package:layer/presentation/screens/auth/OtpVerification.dart';
import 'package:layer/presentation/screens/auth/registationScreen.dart';
import 'package:layer/presentation/screens/balance%20&%20payment/buyingschhet.dart';
import 'package:layer/presentation/screens/balance%20&%20payment/payment.dart';
import 'package:layer/presentation/screens/home/homescreen.dart';
import 'package:layer/presentation/screens/layer/LawyerDetails.dart';
import 'package:layer/presentation/screens/layer/lawyerListsecetion.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

import 'presentation/screens/Call & Chat/chatDetails.dart';
import 'presentation/screens/Call & Chat/chatscreen.dart';
import 'presentation/screens/Call & Chat/videoscreen.dart';
import 'presentation/screens/auth/profile.dart';

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

