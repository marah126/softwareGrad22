// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanad_software_project/adminPages/chat.dart';
import 'package:http/http.dart' as http;
import 'package:sanad_software_project/specialestPages/cchhaat.dart';
import 'package:sanad_software_project/theme.dart';



class chatParent extends StatefulWidget {
  final String id;

  const chatParent({super.key, required this.id});
  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chatParent> {
  
  late String name;
   late final List<dynamic> data;
  List<String> imagePath = [];
  List<String> imageID = [];
  List<String> EMP = [];

  final auth=FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance;
  late User? user;

  void getUser(){
    try{
        final currentUser = auth.currentUser;
      if (currentUser != null) {
        setState(() {
          user = currentUser;
        });
        print("email firestore ");
        print(user!.email);
      }
    }catch(e){
      print(e);
    }
  }
  Future<void> getSPname()async{
  final spName = await http.get(Uri.parse("$ip/sanad/getsppnename?id=${widget.id}"));
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


   Future<void> getEmployeeName() async {
    // print("childrenssssssssssss");
    final EmployeeNamesResponse =
        await http.get(Uri.parse(ip + "/sanad/getSpecialists?cid=${widget.id}"));
    if (EmployeeNamesResponse.statusCode == 200) {
      EMP.clear();
      String EmployeeName;
      data = jsonDecode(EmployeeNamesResponse.body);

      for (int i = 0; i < data.length; i++) {
        print(data[i]['firstName'] + " " + data[i]['lastName']);
        EmployeeName = data[i]['firstName'] + " " + data[i]['lastName'];
        setState(() {
          EMP.add(EmployeeName);
        });
      }
      for (int i = 0; i < EMP.length; i++) {
        print("ch" + data[i]['idd']);
      }
    } else {
      print("errrrrrrrror");
    }
  }

  Future<void> getSPImages()async{
    String path;
    String id;
    final images = await http.get(Uri.parse(ip+"/sanad/getAllSPImages"));
    if(images.statusCode==200){
      print(images.body);
    final List<dynamic> image = jsonDecode(images.body);
      for(int i=0;i<image.length;i++){
        path=image[i]['path'];
        id=image[i]['spID'];
        print(path);
        print(id);
        imagePath.add(path);
        imageID.add(id);
      }
      
    }
  }


  

  List<Map<String, String>> Freinds = [
    {
      'date': 'أمس',
      'name': 'سارة حنو',
      'message': ' اوك',
      'image': 'assets/images/person1.png'
    },
    
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getSPname();
    getEmployeeName();
    getSPImages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        backgroundColor: Color(0xff6f35a5),
        title: Text('الـدردشـات',style: TextStyle(fontFamily: 'myfont'),),
      ),
      
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4),
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
           SizedBox(height: 20),
           
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: EMP.length,
              itemBuilder: (context, index) {
                  String employee = EMP[index];
                  return GestureDetector(
                  onTap: () async{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen2(receiverID: data[index]['idd'],receiverName: data[index]['firstName'],myId: widget.id,)
                      ),
                    );
                  },
                child: Column(
                  children: <Widget>[
                    Card(
                      color: Color.fromARGB(255, 237, 234, 240),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          
                          Spacer(),                           
                             Column(
                              children: <Widget>[
                                Text(
                                  employee ?? '',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200),
                                ),
                                SizedBox(height: 5),
                            //     Text(
                            // Freinds[index]['message'] ?? '',
                            //       style: TextStyle(
                            //           fontSize: 15, fontFamily: 'myfont'),
                            //     ),
                              ],
                            ),
                            SizedBox(width: 30,),
                            ClipOval(
                              child: imageID.contains(data[index]['id'])
                                  ? Image.network(
                                      'http://192.168.1.19:3000/sanad/getSPImage?id=${imageID[imageID.indexOf(data[index]['id'])]}',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/profileImage.jpg',
                                      width: 70,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          SizedBox(width: 5,),
                        ],
                      ),
                    ),
                    
                  ],

                ),
                  );  
              },
            ),
          ],
        ),
      ),
    );
  }
}
