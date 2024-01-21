// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:sanad_software_project/adminPages/calender.dart';
import 'package:sanad_software_project/adminPages/notifScreen.dart';
import 'package:sanad_software_project/specialestPages/empVications.dart';

class pushNotificationsManager{
  static int no=0;
 static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
  static void  requestPermission() async{
    FirebaseMessaging messaging =FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true
    );

    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print('User granted permission');
    } else if(settings.authorizationStatus==AuthorizationStatus.provisional){
      print('User granted provisional permission');
    } else{
      print('User declined or has not accepted permission');
    }
  }


  static void getToken(String id)async{
    String? myToken ="";
    await FirebaseMessaging.instance.getToken().then(
      (token){
        myToken=token;
        print("My token is $myToken");
    });
    saveToken(myToken!, id);
  }


  static saveToken(String token,String id) async{
    await FirebaseFirestore.instance.collection("notifications").doc('$id').set({
      'token':token,
      'id':id
    });
  }



  static void initInfo(BuildContext context,int user,String id){
    var androidInitialize= const AndroidInitializationSettings('@mipmap/ic_launcher');
    //var iosInitilaize= const IOSI();
    InitializationSettings initializationSettings = InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse:(NotificationResponse event)async{
      try{
        if(event.payload!=null && event.payload!.isNotEmpty){
          print("have payload");
          if(user ==0){
            Navigator.push( context, MaterialPageRoute(builder:( BuildContext context){
            return notificationScreen();
          }));
        }else if(user == 1){
          Navigator.push( context, MaterialPageRoute(builder:( BuildContext context){
            return vications(id: id,);
          }));
        }
          
        }
        else{
          print("no payload");
        }
      }catch(e){
        print("error $e");
      }
      return;
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
      print("...............onMessage...............");
      print("onMessage : ${message.notification?.title}/${message.notification?.body}}");

      BigTextStyleInformation bigTextStyleInformation =BigTextStyleInformation(
        message.notification!.body.toString(),htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics=AndroidNotificationDetails(
        'marah','marah',importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true
        );
      NotificationDetails platformChannelSpecifics=NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
       message.notification?.body, platformChannelSpecifics,
       payload: message.data['body']);
     });
  }


 static void sendPushMessage(String token,String body,String title)async{
    try{
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers:<String,String>{
          'Content-Type':'application/json',
          'Authorization':'key=AAAAUW5wtAU:APA91bEcCTpJciJuZK54PZ12YgWTNSdhKt2Yr_e1VMn2lmTN6S04tI3jgCBaiyb_BRQsDfG0n42ysmOyz5pE2GjPjP5oAm0RbgOihZLGTJE_37Nxq2tjoDblR00BPJN-ljAq9l8ahuWs'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority':'high',
            'data':<String,dynamic>{
              'click_action':'FLUTTER_NOTIFICATION_CLICK',
              'status':'done',
              'body':body,
              'title':title,
            },
            "notification":<String,dynamic>{
              "title":title,
              "body":body,
              "android_channel_id":"marah"
            },
            "to":token,
          }
        ),
      );
    }catch(e){
      print("error push notification $e");
    }
  }

}


// pushNotificationsManager._();
  // factory pushNotificationsManager() => _instance;
  // static final pushNotificationsManager _instance =pushNotificationsManager._();
  // final  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  // bool initilized =false;
  // Future<void> init() async{
  //   if(!initilized){
  //         await firebaseMessaging.requestPermission();

  //     String? token = await firebaseMessaging.getToken();
  //     print("token $token");
  //     initilized = true;
  //   }
  // }