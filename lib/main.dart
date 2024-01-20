import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sanad_software_project/notification.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:sanad_software_project/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  print("Handling a background message ${message.messageId}--${message.notification?.title}--${message.notification?.body}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA1XhBrh9-8S5fSuQr0Ku2r17pTjoGWGJ0",
      appId: "1:349745230853:android:18b77afe31ff4b59c1986c",
      messagingSenderId: "349745230853",
      projectId: "sanadd-870c8",
    ),
  );//:
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  pushNotificationsManager.getToken("admin");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp( MyApp());
}



class MyApp extends StatelessWidget {
 // const MyApp({super.key});
  final auth=FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white
        
      ),
      home: welcome(),
      // locale: const Locale('ar'), // Set the locale to Arabic
      // localizationsDelegates: [
      //   SfGlobalLocalizations.delegate, // Add this delegate for Syncfusion localization
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   const Locale('en'),
      //   const Locale('ar'),
      // ],
    );
  }
}
