// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanad_software_project/adminPages/addNewChild.dart';
import 'package:sanad_software_project/adminPages/addNewSpecialest.dart';
import 'package:sanad_software_project/adminPages/adminHome.dart';
import 'package:sanad_software_project/adminPages/c.dart';
import 'package:sanad_software_project/adminPages/chat.dart';
import 'package:sanad_software_project/adminPages/showAllChildren.dart';
import 'package:sanad_software_project/adminPages/showAllEmployee.dart';
import 'package:sanad_software_project/parents.dart/homePageParent.dart';
import 'package:sanad_software_project/parents.dart/personalPage.dart';
import 'package:sanad_software_project/specialestPages/empPersonalInformation.dart';
import 'package:sanad_software_project/specialestPages/empVications.dart';
import 'package:sanad_software_project/specialestPages/homePage.dart';
import 'package:sanad_software_project/specialestPages/viewChildren.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;


class parentHomeDrawer extends StatefulWidget{
  final String id;

  const parentHomeDrawer({super.key, required this.id});
  @override
  State<StatefulWidget> createState() {
    return _parentHomeDrawerState();
  }
}

class _parentHomeDrawerState extends State<parentHomeDrawer> {
   String id="";
   String name="";
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
    id=widget.id;
    print("home drawer id "+id);
    getUser();
    getImageUrl();
    getSPname();
  }

  Color hoveredColor = primaryLightColor;
   late Widget container=childSchdule(id: id);

    String imageUrl = '';


  Future<void> getImageUrl() async {
    print(id);
    final String serverUrl = '$ip/sanad/getImage?id=$id';

    try {
      final response = await http.get(Uri.parse(serverUrl));
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          imageUrl = serverUrl;
          print(imageUrl);
        });
      } else {
        print('Failed to get image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error getting image: $error');
    }
  }

Future<void> getSPname()async{
  final spName = await http.get(Uri.parse("$ip/sanad/getChildname?id=$id"));
  if(spName.statusCode==200){
    print("body "+spName.body.toString());
    final spNameBody=jsonDecode(spName.body);
      name=spNameBody['Fname']+" "+spNameBody['Lname'];
    
    print("name"+name);
  }
  else{
    print("error"+spName.body);
  }
}


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
                    child: ClipOval(
                      child: imageUrl.isNotEmpty? (Image.network(imageUrl, height: 120.0,width: 150.0,fit: BoxFit.cover,)): 
                                Image.asset('assets/images/nurse.png', width: 120, height: 200,fit: BoxFit.cover,) ,
                    ),
                  ),
                  Text(
                    name,
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
                        container=childSchdule(id: "");
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
                        container=myChildren(id: id,);
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
                          "جــلسات طــفــلــي",
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
                        container=profileChild(id: id,);
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
                          "الـصـفـحـة الـشـخـصـيـة",
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
                        container=vications(id:id);
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
                          "الـحسـاب",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.monetization_on, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                
            ]),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        actions: [
         Builder(
          builder: (BuildContext context) {
           return IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }
         ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context){return ChatScreen();}));
            },
          ),
         ],
       ),
       body: container
       //spHomePage(id: id,name:"فطوم دريني"),
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

