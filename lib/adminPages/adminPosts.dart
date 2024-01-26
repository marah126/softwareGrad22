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


class adminPosts extends StatefulWidget {
  @override
  _adminPostsState createState() => _adminPostsState();
}

class _adminPostsState extends State<adminPosts> {
  bool isExpanded = false;
  int lines = 3;
  int s = 5;
  bool less = false;

  File? _image;
  final firestore=FirebaseFirestore.instance;

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

  Future<void>newPost()async{
     if (_image == null) {
      print('No image selected');
      final url = Uri.parse(ip+'/sanad/newPost'); // Replace with your server's IP
      var request = http.post(url,body: {
        'title':titleController.text.trim(),
        'text':textController.text.trim(),
          'date':formattedDate,
          'time':formattedTime,
      });
      
      

      return;
    }
    
    final url = Uri.parse(ip+'/sanad/newPost'); // Replace with your server's IP
    var request = http.MultipartRequest('POST', url);
    request.fields['title'] = titleController.text.trim();
    request.fields['text']=textController.text.trim();
    request.fields['date']=formattedDate;
    request.fields['time']=formattedTime;
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
    
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      }else if(response.statusCode==201){
        print(response.stream);
      }
       else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      
      }
    }
    catch(error){
      print("error");
    }    
  }

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


  Future<void> sendToken(String title) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore.collection("notifications").get();
    print("gfshgtr");
    final messages = snapshot.docs; 
    print(messages.length);

    for (var message in messages) {
      Map<String, dynamic> data = message.data()!;
      if(data['type']=='child'){
        String id=data['id'];
        String token=data['token'];
        pushNotificationsManager.initInfo(context, 2, id);
        pushNotificationsManager.sendPushMessage(token, " لديك منشور جديد بعنوان $title", "منشور جديد");
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
                      // Divider(
                      //   height: 0.0,
                      //   thickness: 3.0,
                      //   color: Color(0xff6f35a5),
                      //   indent: 0.0, // Set the starting padding
                      //   endIndent: 0.0, // Set the ending padding
                      // ),
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
      floatingActionButton: FloatingActionButton(
        mouseCursor: SystemMouseCursors.verticalText,
        onPressed: () {
          _showAddPostDialog(context);
          print('Floating Action Button pressed');
        },
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  

  void _showAddPostDialog(BuildContext context) {
    formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    formattedTime = DateFormat('HH:mm').format(DateTime.now());
    FilePickerResult? result;
    String selectedFileName = '';
    bool isExpanded = false;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                'إضـافـة مـنـشـور جـديـد',
                style: TextStyle(
                  fontFamily: 'myfont',
                  color: Color(0xff6f35a5),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              content: StatefulBuilder(builder: (context, setState) {
                return SingleChildScrollView(
                  child: Container(
                    height: 600,
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 15),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 10),
                                  Text(formattedDate,
                                      style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.start),
                                  Spacer(),
                                  Text(
                                    'تـاريـخ الـيـوم',
                                    style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textAlign: TextAlign.end,
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  SizedBox(width: 10),
                                  Text(formattedTime,
                                      style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.start),
                                  Spacer(),
                                  Text(
                                    'الـوقـت الـحـالـي',
                                    style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textAlign: TextAlign.end,
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Card(
                          child: Column(children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff6f35a5),
                                    minimumSize: Size(30, 30),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(29),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await _getImage();
                                    setState(() {});
                                    // result = await FilePicker.platform.pickFiles(
                                    //   type: FileType.image,
                                    //   //  allowedExtensions: ['jpg', 'jpeg', 'png'],
                                    // );
                                    // if (result == null) {
                                    //   print("No file selected");
                                    // } else {
                                    //   result?.files.forEach((element) {
                                    //     print(element.name);
                                    //   });
                                    // }
                                  },
                                  child: Text(
                                    'تـحـمـيـل',
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'myFont'),
                                  ),
                                ),
                                SizedBox(width: 85),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                                  child: Text(
                                    'إضـافـة صـورة',
                                    style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _image == null
                                ? Text('No image selected')
                                : Image.file(_image!, height: 50.0),
                            SizedBox(
                              height: 10,
                            )
                          ]),
                        ),
                        SizedBox(height: 15),
                        Card(
                          child: Column(children: [
                            Text(
                              'عــنــوان الـمـنــشــور',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: titleController,
                              decoration: InputDecoration(
                                labelText: ' ',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff6f35a5),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  //      borderRadius: BorderRadius.circular(29.0),
                                  borderSide: BorderSide(
                                    color: Color(0xff6f35a5),
                                  ),
                                ),
                              ),
                              cursorColor: Color(0xff6f35a5),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Card(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'كـتابـة مـنـشـور ',
                                style: TextStyle(
                                    fontFamily: 'myfont',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: textController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  labelText: ' ',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff6f35a5),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    //      borderRadius: BorderRadius.circular(29.0),
                                    borderSide: BorderSide(
                                      color: Color(0xff6f35a5),
                                    ),
                                  ),
                                ),
                                cursorColor: Color(0xff6f35a5),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                titleController.text="";
                                textController.text="";
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text(
                                'إلـغـاء',
                                style: TextStyle(
                                    fontFamily: 'myfont',
                                    color: Color(0xff6f35a5),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () async{
                                newPost();
                                await sendToken(titleController.text);
                                titleController.text="";
                                textController.text="";
                                Navigator.pop(context);
                              },
                              child: Text(
                                'تــم',
                                style: TextStyle(
                                    fontFamily: 'myfamily',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff6f35a5)),
                              ),  
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })
              //     actions: [
              //       TextButton(
              //         onPressed: () {
              //           Navigator.pop(context); // Close the dialog
              //         },
              //         child: Text(
              //           'إلـغـاء',
              //           style: TextStyle(
              //             fontFamily: 'myfont',
              //             color: Color(0xff6f35a5),
              //             fontWeight: FontWeight.bold,
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //       TextButton(
              //         onPressed: () {
              //           showDialog(
              //             context: context,
              //             builder: (BuildContext context) {
              //               return AlertDialog(
              //                 content: Icon(
              //                   Icons.check_circle_outline,
              //                   color: Color(0xff6f35a5), // Set the color of the icon
              //                   size: 70.0,
              //                 ),
              //                 actions: [
              //                   TextButton(
              //                     onPressed: () => Navigator.pop(context),
              //                     child: Text(
              //                       'تــم',
              //                       style: TextStyle(
              //                           fontFamily: 'myfamily',
              //                           fontSize: 10,
              //                           color: Color(0xff6f35a5)),
              //                     ),
              //                   ),
              //                 ],
              //               );
              //             },
              //           );
              //         },
              //         child: Text(
              //           'إضـافـة',
              //           style: TextStyle(
              //             fontFamily: 'myfont',
              //             color: Color(0xff6f35a5),
              //             fontWeight: FontWeight.bold,
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ],
              );
        });
  }
}
