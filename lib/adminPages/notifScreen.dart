// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:sanad_software_project/theme.dart';



class notificationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return notificationScreenState();
  }
}

class notificationScreenState extends State<notificationScreen>{

  final firestore=FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("الإشـعـــارات",style: TextStyle(fontFamily:'myFont',fontSize: 20,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body:
            StreamBuilder<QuerySnapshot>(stream: firestore.collection('messages').orderBy('time').snapshots(), builder: (context,snapshot){
              List<messageContainer>messageWidget=[];
              if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return Text('Error: ${snapshot.error}');
    }
              if (!snapshot.hasData || user == null || snapshot.data == null) {
                print("No data or user is null or snapshot data is null");
                return Text('No data available'); // Or any other fallback UI
              }
              final messages=snapshot.data!.docs;
              print(messages.length);
              for(var message in messages){
                if((message.get('sender')=='admin' && message.get('receiver')==receiverID) || (message.get('sender')==receiverID && message.get('receiver')=='admin')) {
                  print("tteexxtt"+message.get('text'));
                  final mText=message.get('text');
                  final sender=message.get('sender');
                  final receiver=message.get('receiver');
                  final current ='admin';
                  final widget=messageContainer(sender: receiverName,text: mText,isME: sender=="admin",); //currentUser==sender
                  messageWidget.add(widget);
                }
              }
              return Expanded(child:
               ListView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: messageWidget,));
            }),
    );
  }

}

class notifBody{
  final String name;
  final String id;
  final Timestamp time;
  final bool cliked;

  notifBody(this.cliked, {required this.name, required this.id, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cliked?primaryLightColor:Colors.grey,
      child: Row(
        children:[
           SizedBox(width: 10,),
           Image.asset("name"),
           Column(
            children: [
              Text(name,style: TextStyle(fontFamily: 'myFont',fontSize: 18,fontWeight: FontWeight.bold),),
              Text("قــام بــتــقـــديــم طـــلــب إجـــازة جـــديــد",style: TextStyle(fontSize: 18,fontFamily: 'myFont'),),
              Row(
                children: [
                  Text("10 minutes ago"),
                  SizedBox(width: 50,),
                  GestureDetector(
                    child: Text("عـــرض الــتـــفــاصــيــل",style: TextStyle(color: primaryColor,fontFamily: 'myFont'),),
                  ),
                ],
              )
            ],
           )
      ]),
    );
  }
  
}