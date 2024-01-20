// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/specialestPages/sessionNotes.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;

class dailySchedual extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return dailySchedualState();
  }
}

class dailySchedualState extends State<dailySchedual> {
  //late String id;

  List<dynamic> data = [];
  List<DateTime> date = [];
  List<String> children = [];
  List<String> sp = [];
  List<String> sessions = [];
   Map<String, Color> colorMap = {
    'الـلغـة و نــطــق':Color.fromARGB(255, 202, 172, 235),
    'ســلــوكــي': Color(0xffb1a1b3),
    'وظــيــفــي': Color(0xfffff9e6),
    'تــربـيـة خـاصـة': Color(0xffe6f6ff),
    'عــلاج طــبـيـعي': Color(0xffEBFFE5)
  };
  @override
  void initState() {
    super.initState();

    getAllSessions();
  }

  Future<void> getAllSessions() async {
    DateTime dd;
    String s1;
    String s2;
    String s3;

    final allSessions =
        await http.get(Uri.parse(ip + "/sanad/getTodaySessions"));
    if (allSessions.statusCode == 200) {
      final List<dynamic> data = jsonDecode(allSessions.body);
      // print("autoid= "+autoID.toString());
      for (int i = 0; i < data.length; i++) {
        print(data[i]);
        dd = DateTime.parse(data[i]['date']).toLocal();
        date.add(dd);
        s1 = data[i]['child'];
        s2 = data[i]['specialest'];
        s3 = data[i]['session'];
        children.add(s1);
        sp.add(s2);
        sessions.add(s3);
        //s=data[i]['idd']+"\n"+ data[i]['child']+"\n"+ data[i]['specialest']+"\n"+ data[i]['session']+"\n";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        title: Text(
          "الــجــدول الــيـومـي",
          style: TextStyle(fontFamily: 'myFont', fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        width: size.width,
        height: size.height,
        
          child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 8,
                ),
                Container(
                  color: secondaryColor,
                  height: 100,
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        DateFormat.yMMMMd('ar').format(DateTime.now()),
                        style: TextStyle(
                            fontFamily: 'myFont',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: children!.length,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialogg(context, index);
                                },
                                child: Container(
                                  width: size.width * 0.85,
                                  margin: EdgeInsets.symmetric(vertical: 15.0),
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${date[index].hour}:${date[index].minute}', // You can customize the subtitle based on the index
                                              style: TextStyle(
                                                fontFamily: 'myFont',
                                                fontSize: 20.0,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Spacer(),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(children: [
                                                    Text(
                                                      children[
                                                          index], // You can customize the title based on the index
                                                      style: TextStyle(
                                                        fontFamily: 'myFont',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      ": الــطــفـل",
                                                      style: TextStyle(
                                                        fontFamily: 'myFont',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ]),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(children: [
                                                    Text(
                                                      sp[index], // You can customize the title based on the index
                                                      style: TextStyle(
                                                        fontFamily: 'myFont',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      ": الأخــصــائـيـة",
                                                      style: TextStyle(
                                                        fontFamily: 'myFont',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ]),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(children: [
                                                    Text(
                                                      sessions[
                                                          index], // You can customize the title based on the index
                                                      style: TextStyle(
                                                        fontFamily: 'myFont',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      ": الــجـلـسـة",
                                                      style: TextStyle(
                                                        fontFamily: 'myFont',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ]),
                                                ]),
                                          ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                     
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorMap[sessions[index].toLowerCase()]!, // Change this to your desired color
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ]);
                      }),
                ),
              ]),
        ),
      
    );
  }

  void showDialogg(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) {
          Size size = MediaQuery.of(context).size;
          return AlertDialog(
            backgroundColor: primaryLightColor,
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              width: size.width * 0.8,
              height: 200,
              color: primaryLightColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      RoundedButton(text: "تــعــديــل",press: () {},color: primaryLightColor,textColor: Colors.black),
                      SizedBox(
                        height: 30,
                      ),
                      RoundedButton(text: "حـــذف",press: () {},color: primaryColor,textColor: Colors.white),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
