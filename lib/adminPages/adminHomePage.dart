// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanad_software_project/adminPages/addNewChild.dart';
import 'package:sanad_software_project/adminPages/addNewSpecialest.dart';
import 'package:sanad_software_project/adminPages/adminHome.dart';
import 'package:sanad_software_project/adminPages/c.dart';
import 'package:sanad_software_project/adminPages/chat.dart';
import 'package:sanad_software_project/adminPages/dailyScheduale.dart';
import 'package:sanad_software_project/adminPages/notifScreen.dart';
import 'package:sanad_software_project/adminPages/showAllChildren.dart';
import 'package:sanad_software_project/adminPages/showAllEmployee.dart';
import 'package:sanad_software_project/adminPages/viewemployeeToChat.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;


class adminHomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _adminHomePageState();
  }
}

class _adminHomePageState extends State<adminHomePage> {
  final auth=FirebaseAuth.instance;
  void getUser(){
    try{
      final user=auth.currentUser;
      if(user != null){
        print(user.email);
      }
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Color hoveredColor = primaryLightColor;
   Widget container=adminHome();
  @override
  Widget build(BuildContext context) {
   Size size=MediaQuery.of(context).size;               
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: primaryLightColor,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
               Container(
              color: primaryColor,
              width: double.infinity,
              height: 250,
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/admin.png'),
                      ),
                    ),
                  ),
                  Text(
                    "الـإدارة",
                    style: TextStyle(color: Colors.white, fontSize: 24,fontFamily: 'myFont'),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=adminHome();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "الصـفـحـة الرئـسـيـة",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.home, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=calenderr();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "إعـدادالجــدول",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.calendar_month, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=viewChildren();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "الأطـــفـــال",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.child_care, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=viewSpecialest();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "الأخــصــائــيـيـن",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.person, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=newChild();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "إضـافـة طــفـل جـديـد",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.face_retouching_natural, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=newSpecialest();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "إضـافـة أخـصـائـي جـديـد",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.person_add, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=notificationScreen();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "إضـافـة",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.person_add, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
            ]),
          ),
        ),
      ),
      appBar: AppBar(
  backgroundColor: primaryColor,
  automaticallyImplyLeading: false,
  actions: [
    IconButton(
      icon: Icon(Icons.notifications),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return notificationScreen();
        }));
      },
    ),
    IconButton(
      icon: Icon(Icons.wechat),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return chat();
        }));
      },
    ),
    Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        );
      },
    ),
  ],
),
       body: container,
      // Container(
      //   width: size.width,
      //   height: size.height,
      //   child: Stack(children: [
      //     Positioned(
      //         bottom: 0,
      //         right: 0,
      //         child: Image.asset("assets/images/welcome_bottom_right.png")),
      //     Column(
      //       children: [
      //         Container(
      //           child: SfCalendar(
      //             view: CalendarView.schedule,
      //         ),)
      //       ],)
      //   ]),
      //),
    );
  }
  
}


// class adminHome extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return adminHomeState();
//   }
// }

// class adminHomeState extends State<adminHome>{
//   @override
//   Widget build(BuildContext context) {
//     Size size=MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         width: size.width,
//         // height: double.infinity,
//          child:
//         // Stack(children: [
//         //   Positioned(
//         //       bottom: 0,
//         //       right: 0,
//         //       child: Image.asset("assets/images/welcome_bottom_right.png")),
//           Column(
//             children: [
//               Container(
//                 child: SfCalendar(
//                   dataSource: _getCalendarAppointments(),
//                   view: CalendarView.schedule,
//                   todayHighlightColor: primaryColor,
//                   scheduleViewSettings: ScheduleViewSettings(
//                     appointmentItemHeight: 50,
//                     hideEmptyScheduleWeek: true,
//                     appointmentTextStyle: TextStyle(color: Colors.black,fontFamily: 'myFont',fontSize: 16),
//                     weekHeaderSettings: WeekHeaderSettings(
//                       startDateFormat: " ",
//                       endDateFormat: " ",
//                     ),
//                     dayHeaderSettings: DayHeaderSettings(
//                       dayTextStyle: TextStyle(color: primaryColor,fontSize: 17)
//                     ),
//                     monthHeaderSettings: MonthHeaderSettings(
//                       monthTextStyle: TextStyle(color: primaryLightColor,fontWeight: FontWeight.bold),
//                       backgroundColor: secondaryColor
//                     )
//                   ),
//               ),)
//             ],)
//         ),
      
//     );
//   }

//   Map<String, Color> colorMap = {
//     'الـلغـة و نــطــق': primaryLightColor,
//     'ســلــوكــي': Color(0xffb1a1b3),
//     'وظــيــفــي': Color(0xfffff9e6),
//     'تــربـيـة خـاصـة': Color(0xffe6f6ff),
//     'عــلاج طــبـيـعي': Color(0xffEBFFE5)
//   };
//   static  List<String> children = [
//      ' ',
//     // 'Item 2',
//     // 'Item 3',
//     // 'Item 4',
//     // 'Item 5',
//     // 'Item 11',
//     // 'Item 21',
//     // 'Item 31',
//     // 'Item 41',
//     // 'Item 51',
//     // 'Item 12',
//     // 'Item 22',
//     // 'Item 32',
//     // 'Item 42',
//     // 'Item 52',
//   ];
//   static  List<String> specialests = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//     'Item 11',
//     'Item 21',
//     'Item 31',
//     'Item 41',
//     'Item 51',
//     'Item 12',
//     'Item 22',
//     'Item 32',
//     'Item 42',
//     'Item 52',
//   ];
//   List<CustomEvent> events = [];
//   static const List<String> sessions = [
//     'الـلغـة و نــطــق',
//     'ســلــوكــي',
//     'وظــيــفــي',
//     'تــربـيـة خـاصـة',
//     'عــلاج طــبـيـعي',
//   ];
//   String selectedValue = children.first;
//   String selectedValue2 = specialests.first;
//   String selectedValue3 = sessions.first;
//   String selectedDateweek = "";
//   String day="";

//   List<DateTime> visibleDates = [];
//   List<String> visibleDatesString = [];
//   late CustomEvent newSession;

//   int autoID=0;
//    CalendarDataSource _getCalendarAppointments() {
//     DateTime d = DateTime.now();
//     DateTime firstDayOfNextMonth = DateTime(d.year, d.month + 1, 1);
//     DateTime lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
//    // d = d.add(const Duration(days: 10));
//     final List<Appointment> appointments = <Appointment>[];

//     for (final CustomEvent event in events) {
//       appointments.add(Appointment(
//           id: event.id,
//           startTime: event.from,
//           endTime: event.to,
//           subject: event.child+"  --  "+event.specialest+"  --  "+event.session,
//           color: event.color,
//           recurrenceRule: 'FREQ=DAILY;INTERVAL=7;UNTIL=$lastDayOfCurrentMonth'));
//     }
//     return _DataSource(appointments);
//   }

//   Future<void> getChildrenNames() async{
//     int x=0;
//     if (x == 0) {
//       print("childrenssssssssssss");
//       final childreNamesResponse =
//           await http.get(Uri.parse(ip + "/sanad/getchname"));
//       if (childreNamesResponse.statusCode == 200) {
//         children.clear();
//         String childName;
//         final List<dynamic> data = jsonDecode(childreNamesResponse.body);

//         for (int i = 0; i < data.length; i++) {
//           print(data[i]['Fname'] + " " + data[i]['Lname']);
//           childName = data[i]['Fname'] + " " + data[i]['Lname'];
//           setState(() {
//             children.add(childName);
//           });
//         }
//         for(int i=0;i<children.length;i++){
//           print("ch"+children[i]);
//         }
//       } else {
//         print("errrrrrrrror");
//       }
//       x++;
//     }
//       if (x == 1) {
//       final specialestNamesResponse =
//           await http.get(Uri.parse(ip + "/sanad/getspname"));
//       if (specialestNamesResponse.statusCode == 200) {
//         specialests.clear();
//         String spName;
//         final List<dynamic> data2 = jsonDecode(specialestNamesResponse.body);

//         for (int i = 0; i < data2.length; i++) {
//           print(data2[i]['Fname'] + " " + data2[i]['Lname']);
//           spName = data2[i]['Fname'] + " " + data2[i]['Lname'];
//           setState(() {
//             specialests.add(spName);
//           });
//         }
//         for(int i=0;i<specialests.length;i++){
//           print("sp"+specialests[i]);
//         }
//       } else {
//         print("errrrrrrrror");
//       }
//     }
//   }
  

//   Future<void> getAllSessions()async{

//     CustomEvent e;
//     DateTime dd;
//     String s;
//     final allSessions=await http.get(Uri.parse(ip+"/sanad/getallsessions"));
//     if (allSessions.statusCode == 200) {
//         String childName;
//         final List<dynamic> data = jsonDecode(allSessions.body);
//         autoID=data.length;
//         print("autoid= "+autoID.toString());
//         for(int i=0;i<data.length;i++){
//           print(data[i]);
//           dd=DateTime.parse(data[i]['date']).toLocal();
//           s=data[i]['session'];
//           e=CustomEvent(data[i]['idd'], data[i]['child'], data[i]['specialest'], data[i]['session'], dd, dd.add(Duration(minutes: 40)), colorMap[s.toLowerCase()]!);
//           events.add(e);
//         }
//     }
//   }

//   Future<void> _loadData() async {
//   await getChildrenNames();
//   await getAllSessions();
//   // Additional code that should execute after both functions are complete
// }

//   @override
//     void initState() {
//       super.initState();
      
//       // Call your function here
//        getChildrenNames();
//        getAllSessions();
//       //_loadData();
//     }


// }


// class CustomEvent {
//   CustomEvent(this.id, this.child, this.specialest, this.session, this.from,
//       this.to, this.color);
//   int id;
//   String child;
//   String specialest;
//   String session;
//   DateTime from;
//   DateTime to;
//   Color color;
// }

// class _DataSource extends CalendarDataSource {
//   _DataSource(List<Appointment> source) {
//     appointments = source;
//   }
// }
