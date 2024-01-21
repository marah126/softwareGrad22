// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:sanad_software_project/theme.dart';

class notificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return notificationScreenState();
  }
}

class notificationScreenState extends State<notificationScreen> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  late User? user;

  static List<bool>cliked=[];
   int index=0;

  void getUser() {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        setState(() {
          user = currentUser;
        });
        print(user!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Text(
          "الإشـعـــارات",
          style: TextStyle(
              fontFamily: 'myFont', fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
            stream:
                firestore.collection('notifInfo').orderBy('time',descending: true).snapshots(),
            builder: (context, snapshot) {
              List<notifBody> notifBodyWidget = [];
              index=0;
              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data == null) {
                //user == null ||
                print("No data or user is null or snapshot data is null");
                return Text('No data available'); // Or any other fallback UI
              }
              final messages = snapshot.data!.docs;
              print(messages.length);
              for (var message in messages) {
              
                final id = message.get("id");
                final name = message.get('name');
                final startDate = message.get('startDate');
                final endDate = message.get('endDate');
                final reason = message.get('reason');
                final type = message.get("type");
                final time = message.get("time");
                final widget = notifBody( name: name, id: id, time: time,index: index,type: type,reason: reason,startDate: startDate,endDate: endDate,);
                notifBodyWidget.add(widget);
                cliked.add(false);
                index++;
                print("indexs $index");
              }
              return Column(children: [
                Expanded(
                    child: Container(
                  width: size.width,
                  child: ListView(
                    //controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: notifBodyWidget,
                  ),
                ))
              ]);
            }),
      ),
    );
  }
}

class notifBody extends StatefulWidget {
  final String name;
  final String id;
  final String startDate;
  final String endDate;
  final String type;
  final String reason;
  final Timestamp time;
  final int index;

  notifBody({required this.name, required this.id, required this.time, required this.index, required this.startDate, required this.endDate, required this.type, required this.reason, });

  @override
  _notifBodyState createState() => _notifBodyState();
}

class _notifBodyState extends State<notifBody> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Container(
      width: size.width,
      color: notificationScreenState.cliked[widget.index] ? primaryLightColor : const Color.fromARGB(255, 224, 222, 222),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    "قــام بــتــقـــديــم طـــلــب إجـــازة جـــديــد  ",
                    style: TextStyle(fontSize: 16, fontFamily: 'myFont'),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontFamily: 'myFont',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  GestureDetector(
                    child: Text(
                      "عـــرض الــتـــفــاصــيــل",
                      style: TextStyle(color: primaryColor, fontFamily: 'myFont',fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      showDetails(widget.id, widget.name, widget.type, widget.reason, widget.startDate, widget.endDate);
                      setState(() {
                        notificationScreenState.cliked[widget.index] = true;
                      });
                      
                    },
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Text("10 minutes ago",style: TextStyle(color: Colors.black54),),
                ],
              ),
              SizedBox(height: 5,),
            ],
          ),
          Image.asset(
            "assets/images/notif.png",
            width: 50,
            height: 50,
          ),
        ],
      ),
    );
  }

   void showDetails(String id ,String name , String type, String reason ,String startDate,String endDate){
    showDialog(context: context, builder: (context){
      Size size =MediaQuery.of(context).size;
      return AlertDialog(
        titleTextStyle: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,color: secondaryColor,fontSize: 22),
        title: Text("طــلــب إجــازة",textAlign: TextAlign.center,),
        backgroundColor: Colors.white,
        content: Container(
          height: size.width,
          width: size.width*0.8,
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text(name,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                SizedBox(width: 10,),
                Text(": الــموظــف/ة",style: TextStyle(fontFamily: 'myFont',fontSize: 18,fontWeight: FontWeight.bold,color: secondaryColor))
              ],),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text(startDate,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                SizedBox(width: 10,),
                Text(": بــدايــة الإجـــازة ",style: TextStyle(fontFamily: 'myFont',fontSize: 18,fontWeight: FontWeight.bold,color: secondaryColor))
              ],),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text(endDate,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                SizedBox(width: 10,),
                Text(": انــتــهــاء الإجـــازة ",style: TextStyle(fontFamily: 'myFont',fontSize: 18,fontWeight: FontWeight.bold,color: secondaryColor))
              ],),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text(type,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                SizedBox(width: 10,),
                Text(": نـــوع الإجـــازة ",style: TextStyle(fontFamily: 'myFont',fontSize: 18,fontWeight: FontWeight.bold,color: secondaryColor))
              ],),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text(reason,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                SizedBox(width: 10,),
                Text(": ســـبــب الإجــازة",style: TextStyle(fontFamily: 'myFont',fontSize: 18,fontWeight: FontWeight.bold,color: secondaryColor))
              ],),
              SizedBox(height: 40,),
            ],

          ),
        ),
      );
    });
  }
}

