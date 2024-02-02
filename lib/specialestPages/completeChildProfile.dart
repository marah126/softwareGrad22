// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sanad_software_project/theme.dart';

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
  final String id;

  const edit({super.key, required this.id});
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<edit> {
  File? _image;
  File? _image2;

  bool isExpanded = false;

  FilePickerResult? result;
  String selectedFileName = '';

  Future<void> _getImage(int x) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(x==1){
      if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print(pickedFile.path);
      });
    }
    }
    else if(x==2){
      if (pickedFile != null) {
      setState(() {
        _image2 = File(pickedFile.path);
        print(pickedFile.path);
      });
    }
    }
  }

  File? _file;

  Future<void> _getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    setState(() {
      if (result != null) {
        _file = File(result.files.single.path!);
      }
    });
  }



  Future<void>personalImage()async{
     if (_image == null) {
      print('No image selected');
      return;
    }
    final url = Uri.parse(ip+'/sanad/uploadSP'); // Replace with your server's IP
    var request = http.MultipartRequest('POST', url);
    request.fields['spID'] = widget.id;
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


  Future<void>idImage()async{
     if (_image == null) {
      print('No image selected');
      return;
    }
    final url = Uri.parse(ip+'/sanad/uploadJobimageSP'); // Replace with your server's IP
    var request = http.MultipartRequest('POST', url);
    request.fields['spID'] = widget.id;
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

  Future<void> _uploadFile() async {

    if (_file == null) {
      // Handle case where no file is selected
      return;
    }
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ip + '/sanad/uploadfileSP'),
    );
    // Add file to the request
    request.fields['spID'] = widget.id;
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        _file!.path,
        contentType: MediaType('application', 'pdf'),
      ),
    );
    // Send the request
    var response = await request.send();
    // Check the server response
    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print('File upload failed with status ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
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
                        onTap: (){
                          _getImage(1);
                        },
                        child: ClipOval(child: _image==null?Image.asset("assets/images/profileImage.jpg"):
                        Image.file(_image!,height: 120,width: 120,fit: BoxFit.cover,))
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
                            fontFamily: 'myFont',
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
                      onPressed: ()  {
                        _getImage(2);
                      },
                      child: Text(
                        'إرفـاق',style: TextStyle(fontFamily: 'myFont'),
                      )
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
              SizedBox(height: 5,),
              _image2==null?
                SizedBox(height: 40):Image.file(_image2!,height: 70,),
                SizedBox(height: 5,),
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
                        _getFile();
                      },
                      child: Text(
                        'إرفـاق',style:TextStyle(fontFamily: 'myFont') ,
                      ),
                    ),
                    SizedBox(width: 80),
                    Text(
                      'إرفـاق الـسـيـرة الـذاتـيـة',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'myFont'
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
               _file != null
                ? Text('Selected File: ${path.basename(_file!.path)}'):
                  SizedBox(height: 80),
                  SizedBox(height: 10,),
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
                      personalImage();
                      idImage();
                      _uploadFile();
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

  
}