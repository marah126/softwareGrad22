// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanad_software_project/theme.dart';
//import 'package:software/parentPages/completeChildProfile.dart';
import 'package:http/http.dart' as http;

class profileChild extends StatefulWidget {
  final String id;

  const profileChild({super.key, required this.id});
  @override
  profileChildState createState() => profileChildState();
}
class profileChildState extends State<profileChild> {
  late String id;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mphoneController = TextEditingController();

  TextEditingController _textFieldController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool pressed = false;
  String name = '';
  String fatherphone = '';
  String motherphone='';
  String emailString = '';
  String idd = '';
  String startDate = " ";
  String birthDate = '';
  String fsession = '';
  late DateTime bd;
  late DateTime sd;
  late DateTime fs;
  String diagnose = '';
  String imageUrl = "";
  List <dynamic> sessions=[];

  bool _isTextFieldEnabled = false;

  Future<void> getspinfo() async {
    final spInfo = await http.get(Uri.parse('$ip/sanad/getChildInfoByID?id=$id'));
    final email = await http.get(Uri.parse('$ip/sanad/getEmail?id=$id'));
    if (spInfo.statusCode == 200) {
      print("body" + spInfo.body);
      final spInfoBody = jsonDecode(spInfo.body);
      name = spInfoBody['firstName'] +
          " " +
          spInfoBody['secondName'] +
          " " +
          spInfoBody['thirdName'] +
          " " +
          spInfoBody['lastName'];
      fatherphone = spInfoBody['fatherPhone'];
      motherphone = spInfoBody['motherPhone'];

      diagnose = spInfoBody['diagnosis'];
      idd = id;
      bd = DateTime.parse(spInfoBody['birthDate']).toLocal();
      sd = DateTime.parse(spInfoBody['enteryDate']).toLocal();
      fs = DateTime.parse(spInfoBody['firstSessionDate']).toLocal();

      birthDate = DateFormat('yyyy/MM/dd').format(bd);
      startDate = DateFormat('yyyy/MM/dd').format(sd);
      fsession = DateFormat('yyyy/MM/dd').format(fs);
      sessions=spInfoBody['sessions'];
      print(sessions.length);
      print(sessions[0]['specialest']);


      if (email.statusCode == 200) {
        print("email " + email.body);
        final emailBody = jsonDecode(email.body);
        emailString = emailBody['email'];
      }
    }
  }

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

  Future<void> updatee()async{
    bool phone=false;
    bool e=false;
    final update= await http.put(Uri.parse('$ip/sanad/updatePhone'),body: {
      'id':idd,
      'motherPhone':motherphone,
      'fatherPhone':fatherphone
    });
   
    if(update.statusCode==200){
      phone=true;
    }
    else{
      print("error in phone update");
    }
    
    if(phone ){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("تــم الـــتــعـديــل",style: TextStyle(color: primaryColor,fontFamily: 'myFont',fontSize: 20,fontWeight: FontWeight.bold),),
        );
      });
    }
  }



  @override
  void initState() {
    super.initState();
    id = widget.id;
    print("child info id " + id);
    getImageUrl();
    getspinfo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xff6f35a5),
        title: Text(
          'الـمـعـلـومـات الـشـخـصـيـة',
          style: TextStyle(fontFamily: 'myfont'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        color: primaryLightColor,
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ClipOval(
                          child: imageUrl.isNotEmpty
                              ? (Image.network(
                                  imageUrl,
                                  height: 200.0,
                                  width: 200.0,
                                  fit: BoxFit.cover,
                                ))
                              : Image.asset(
                                  'assets/images/profileImage.jpg',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText: name,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'الاسـم الـربـاعـي',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: emailController,
                                         enabled: false,
                                        decoration: InputDecoration(
                                          labelText: emailString,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' الـبـريـد الالـكـترونـي',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText: idd,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '  رقـم الـهـويـة',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: phoneController,
                                        enabled: _isTextFieldEnabled,
                                        onTap: () {
                                          if (!_isTextFieldEnabled) {
                                            phoneController.clear();
                                          }
                                        },
                                        onChanged: (text) {
                                          setState(() {
                                            fatherphone = phoneController.text;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: fatherphone,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' رقم هــاتــف الأب',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: mphoneController,
                                        enabled: _isTextFieldEnabled,
                                        onTap: () {
                                          if (!_isTextFieldEnabled) {
                                            mphoneController.clear();
                                          }
                                        },
                                        onChanged: (text) {
                                          setState(() {
                                            motherphone = mphoneController.text;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: motherphone,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' رقم هــاتــف الأم',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                 SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText: birthDate,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '  تـاريـخ الـميـلاد',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText: startDate,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '  تـاريـخ الـدخـول',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText: fsession,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '  تـاريـخ أول جـلــسـة',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText: diagnose,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '  الــتــشـخـيـص',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                SizedBox(height: 16,),
                                Column(children: [
                                  Row(children: [
                                    Text("الأخـصـائـيــة",style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Spacer(),
                                      Text("الـعـدد",style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Spacer(),
                                      Text("الــجـلـسـة",style: TextStyle(
                                        fontFamily: 'myfont',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],),
                                  SizedBox(height: 10,),
                                  for(int i=0;i<sessions.length;i++)
                                  Column(
                                    children:[ Row(children: [
                                      Text(sessions[i]['specialest'],style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                        Spacer(),
                                        Text(sessions[i]['no'].toString(),style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                        Spacer(),
                                        Text(sessions[i]['sessionName'],style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                    ],),
                                    SizedBox(height: 10,)
                                ]),
                                ],),
                                SizedBox(height: 40),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          pressed = true;
                                          setState(() {
                                            _isTextFieldEnabled =
                                                !_isTextFieldEnabled;
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(builder: (context) {
                                            //   return edit();
                                            // }));
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xff6f35a5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(29.0),
                                          ),
                                        ),
                                        child: Text(
                                          'تـعـديـل',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'myfont',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    Visibility(
                                      visible: pressed,
                                      child: Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            pressed = false;
                                            setState(() {
                                              _isTextFieldEnabled =
                                                  !_isTextFieldEnabled;

                                              phoneController.text =
                                                  nameController.text;
                                              emailController.text =
                                                  nameController.text;

                                                  updatee();
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xff6f35a5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(29.0),
                                            ),
                                          ),
                                          child: Text(
                                            'تـم',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'myfont',
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Image.asset('assets/images/image1.png'),
                      )
                    ],
                  ),
        ),
        )
        );

              
             
        
      
    
  } 
}
