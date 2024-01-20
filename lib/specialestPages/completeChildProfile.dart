import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: TestPage(), debugShowCheckedModeBanner: false);
//   }
// }

class edit extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<edit> {
  Uint8List? _imageBytes;
  bool isExpanded = false;

  FilePickerResult? result;
  String selectedFileName = '';
  final String defaultImage = 'assets/default_image.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6f35a5),
        title: Text(
          'إكـمـال الـصـفـحـة الـشـخـصـيـة',
          style: TextStyle(fontFamily: 'myfont'),
        ),
      ),
      
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: getImage,
                        child: _imageBytes == null
                            ? Image.asset(
                                'assets/images/profileImage.jpg',
                                width: 200,
                                height: 200,
                              )
                            : Image.memory(
                                _imageBytes!,
                                width: 200,
                                height: 200,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'إدراج صورة شخصية',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'myfamily',
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 70),
              Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFF1E6FF),
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(
                    color: Color(0xff6f35a5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff6f35a5),
                        minimumSize: Size(30, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29),
                        ),
                      ),
                      onPressed: () async {
                        result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                          //  allowedExtensions: ['jpg', 'jpeg', 'png'],
                        );
                        if (result == null) {
                          print("No file selected");
                        } else {
                          setState(() {
                            selectedFileName = 'تــــم';
                          });

                          result?.files.forEach((element) {
                            print(element.name);
                          });
                        }
                      },
                      child: Text(
                        selectedFileName.isNotEmpty
                            ? selectedFileName
                            : 'إرفـاق',
                      ),
                    ),
                    //  SizedBox(width: 50),
                    Spacer(),
                    Text(
                      'صـورة مـزاولـة الـمـهـنـة ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'myfont',
                      ),
                    ),
//Spacer(),
                    SizedBox(width: 20),
                  ],
                ),
              ),
                SizedBox(height: 40),
              Container(
                height: 50,
                width: 310,
                decoration: BoxDecoration(
                  color: Color(0xFFF1E6FF),
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(
                    color: Color(0xff6f35a5),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff6f35a5),
                        minimumSize: Size(30, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29),
                        ),
                      ),
                      onPressed: () async {
                        result = await FilePicker.platform
                            .pickFiles(allowMultiple: true);
                        if (result == null) {
                          print("No file selected");
                        } else {
                          setState(() {
                            selectedFileName = 'تــــم';
                          });

                          result?.files.forEach((element) {
                            print(element.name);
                          });
                        }
                      },
                      child: Text(
                        selectedFileName.isNotEmpty
                            ? selectedFileName
                            : 'إرفـاق',
                      ),
                    ),
                    SizedBox(width: 80),
                    Text(
                      'إرفـاق الـسـيـرة الـذاتـيـة',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
                  SizedBox(height: 80),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff6f35a5),
                      minimumSize: Size(50, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            29), 
                      ), 
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Text(
                                  'تـم تـخـزيـن الـمـعـلومـات بـنـجـاح',
                                  style: TextStyle(
                                    fontFamily: 'myfont',
                                    color: Color(0xff6f35a5),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.check_circle,
                                  color: Color(0xff6f35a5),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'تـم',
                                  style: TextStyle(
                                    fontFamily: 'myfont',
                                    color: Color(0xff6f35a5),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      print('Button Pressed');
                    },
                    child: Text(
                      'تـخـزيـن',
                      style: TextStyle(fontFamily: 'myfont', fontSize: 20),
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageBytes = File(pickedFile.path).readAsBytesSync();
      }
    });
  }
}