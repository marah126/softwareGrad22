// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sanad_software_project/notification.dart';
import 'dart:io';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;


class viewPostsParernt extends StatefulWidget {
  @override
  _viewPostsState createState() => _viewPostsState();
}

class _viewPostsState extends State<viewPostsParernt> {
  bool isExpanded = false;
  int lines = 3;
  int s = 5;
  bool less = false;

  File? _image;

  late String formattedDate;
  late String formattedTime;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();


  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print(pickedFile.path);
      });
    }
  }

  List<Map<String, String>> dynamicposts = [
    {
      'title': "توعية",
      'date': '17/12/2023',
      'time': '01:21 AM',
      'data':
          '- من المسببات في تأخر اللغة عند الأطفال 🗣️🤔• مشاهدة الأجهزة الإلكترونية لساعات طويلة بمفرده • عدم محاورة الطفل خاصة في الأشهر الأولى من ولادته • عدم دمج الطفل مع أقرانه • إدخال أكثر من لغة للطفل في عمر صغير و بطريقة عشوائية مما يجعل الطفل مشتت بين اللغات وغير قادر على بناء منظومة لغوية كافية و قواعد سليمة . ✨أخصائية النطق والسمع : تيما جرارعة ✨المسببات في تأخر اللغة عند الأطفال 🗣️🤔• مشاهدة الأجهزة الإلكترونية لساعات طويلة بمفرده • عدم محاورة الطفل خاصة في الأشهر الأولى من ولادته • عدم دمج الطفل مع أقرانه • إدخال أكثر من لغة للطفل في عمر صغير و بطريقة عشوائية مما يجعل الطفل مشتت بين اللغات وغير قادر على بناء منظومة لغوية كافية و قواعد سليمة . ✨أخصائية النطق والسمع : تيما جرارعة ✨المسببات في تأخر اللغة عند الأطفال 🗣️🤔• مشاهدة الأجهزة الإلكترونية لساعات طويلة بمفرده • عدم محاورة الطفل خاصة في الأشهر الأولى من ولادته • عدم دمج الطفل مع أقرانه • إدخال أكثر من لغة للطفل في عمر صغير و بطريقة عشوائية مما يجعل الطفل مشتت بين اللغات وغير قادر على بناء منظومة لغوية كافية و قواعد سليمة . ✨أخصائية النطق والسمع : تيما جرارعة ✨',
      'image': 'assets/images/posts.jpg'
    },
    
  ];
  
  List <String> images=[];



 void getPosts()async{
    dynamicposts=[];
    final allPosts=await http.get(Uri.parse("$ip/sanad/getPosts"));
    if(allPosts.statusCode==200){
      final List<dynamic> data = jsonDecode(allPosts.body);
      int length=data.length -1;
      for(int i=0 ; i<data.length ; i++){
        Map<String, String> newPost = {
        'title': data[length-i]['title'],
        'date': data[length-i]['date'],
        'time': data[length-i]['time'],
        'data': data[length-i]['text'],
        'image': 'assets/images/posts.jpg',
      };
      dynamicposts.add(newPost);
      String s=data[length-i]['imageName'];
      if(s.trim()==""){
        print("empty index $i");
        images.add("");
      }
      else{
        s="$ip/sanad/getImagePost?filename=${data[length-i]['imageName']}";
        images.add(s);
      }
      
      
      }
    }
  }


  
    


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          " المنشورات",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'myFont',
              fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              for (int i = 0; i < dynamicposts.length; i++)
                Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      
                      Card(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 5),
                              height: isExpanded ? null : 100,
                              child: Center(
                                child: Text(
                                  dynamicposts[i]['title'] ?? '',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Text(
                              dynamicposts[i]['data'] ?? '',
                              style:
                                  TextStyle(fontFamily: 'myfont', fontSize: 17),
                              maxLines: !isExpanded ? lines : lines + 10,
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!isExpanded)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isExpanded = true;
                                    lines = lines + 20;
                                  });
                                },
                                child: Text(
                                  'قـراءة الـمـزيـد',
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'myfont',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w100),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            Visibility(
                              visible: isExpanded,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    less = true;
                                    isExpanded = false;
                                    lines = lines - 20;
                                  });
                                },
                                child: Text(' عـرض أقـل',
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'myfont',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100),
                                    textAlign: TextAlign.end),
                              ),
                            ),
                            Row(
                              //  crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                Text(dynamicposts[i]['date'] ?? '',
                                    style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                    textAlign: TextAlign.end),
                                SizedBox(width: 200),
                                Text(dynamicposts[i]['time'] ?? '',
                                    style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                    textAlign: TextAlign.start),
                              ],
                            ),
                            Center(
                              child: images[i]==""?Text(""):
                              Image.network(
                                images[i] ?? '',
                                width: 350,
                                height: 300,
                              ),
                            ), 
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      Divider(
                        height: 0.0,
                        thickness: 3.0,
                        color: Color(0xff6f35a5),
                        indent: 0.0,
                        endIndent: 0.0,
                      ),

                      SizedBox(height: 10),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      
    );
  }

  

  
}
