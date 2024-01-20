// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanad_software_project/theme.dart';
//import 'package:software/parentPages/completeChildProfile.dart';
import 'package:http/http.dart' as http;

class profile extends StatefulWidget {
  final String id;

  const profile({super.key, required this.id});
  @override
  profileState createState() => profileState();
}

class profileState extends State<profile> {
  late String id;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool pressed = false;
  String name = '';
  String phone = '';
  String emailString = 'sarahhinno8@gmail.com';
  String idd = '';
  String startDate = " ";
  late DateTime sd;
  String sp = '';
  String imageUrl = "";

  bool _isTextFieldEnabled = false;

  Future<void> getspinfo() async {
    final spInfo = await http.get(Uri.parse('$ip/sanad/getSPInfoByID?id=$id'));
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
      phone = spInfoBody['phone'];
      sp = spInfoBody['specialise'];
      idd = id;
      sd = DateTime.parse(spInfoBody['startDate']).toLocal();
      startDate = DateFormat('yyyy/MM/dd').format(sd);

      if (email.statusCode == 200) {
        print("email " + email.body);
        final emailBody = jsonDecode(email.body);
        emailString = emailBody['email'];
      }
    }
  }

  Future<void> getImageUrl() async {
    print(id);
    final String serverUrl = '$ip/sanad/getSPImage?id=$id';

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

  @override
  void initState() {
    super.initState();
    id = widget.id;
    print("spinfo id " + id);
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
          child: FutureBuilder(
              future: getspinfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Continue building your UI with the fetched data
                  return Column(
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
                                        controller: phoneController,
                                        enabled: _isTextFieldEnabled,
                                        onTap: () {
                                          if (!_isTextFieldEnabled) {
                                            phoneController.clear();
                                          }
                                        },
                                        onChanged: (text) {
                                          setState(() {
                                            phone = phoneController.text;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: phone,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' رقم الهاتف',
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
                                        enabled: _isTextFieldEnabled,
                                        onTap: () {
                                          if (!_isTextFieldEnabled) {
                                            emailController.clear();
                                          }
                                        },
                                        onChanged: (text) {
                                          setState(() {
                                            emailString = emailController.text;
                                          });
                                        },
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
                                      '  تـاريـخ بـدايـة الـعـمـل',
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
                                          labelText: sp,
                                          labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'myfont',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '  أخـصـائـي',
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
                  );
                }
              }),
        ),
      ),
    );
  }
}
