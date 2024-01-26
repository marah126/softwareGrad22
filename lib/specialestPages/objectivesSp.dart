// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sanad_software_project/theme.dart';

class objectives extends StatefulWidget {
  final String childId;
  final String spId;

  const objectives({super.key, required this.childId, required this.spId});
  @override
  _objectivesState createState() => _objectivesState();
}

class _objectivesState extends State<objectives> {
  bool isChecked = false;

  List<Map<String, String>> obj1 = [
    {'percentage': '20%', 'object': '---------------------------------'},
    {'percentage': '50%', 'object': '--------------------------'},
    {'percentage': '40%', 'object': '-------------------------'},
  ];
  List<Map<String, String>> obj2 = [
    {'percentage': '50%', 'object': '======================'},
    {'percentage': '70%', 'object': '==============='},
    {'percentage': '90%', 'object': '=============='},
  ];
  List<Map<String, String>> obj3 = [
    {'percentage': '50%', 'object': '%%%%%%%%%%%'},
    {'percentage': '70%', 'object': '%%%%%%%%%%%%%%%%%%%%'},
    {'percentage': '90%', 'object': '%%%%%%%%%%%%%%%%%%'},
    {'percentage': '70%', 'object': '%%%%%%%%%%%%%%%%%%%%'},
    {'percentage': '90%', 'object': '%%%%%%%%%%%%%%%%%%%'},
  ];
  List<Map<String, String>> obj4 = [
    {'percentage': '50%', 'object': '************'},
    {'percentage': '70%', 'object': '***************************'},
    {'percentage': '90%', 'object': '********************************'},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          " الأهـداف",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'myFont',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(height: 5),
                Text(
                  'العـلاج الـوظـيـفـي',
                  style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'myfont',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
                Card(
                  color: Color.fromARGB(255, 242, 239, 193),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '-: الـتـركـيـز والانـتـبـاه -',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myfont',
                            fontSize: 25,
                            fontWeight: FontWeight.w200),
                        textAlign: TextAlign.end,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          for (int i = 0; i < obj1.length; i++)
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      obj1[i]['percentage'] ?? '',
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        color: Color(0xff161A30),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      obj1[i]['object'] ?? '',
                                      style: TextStyle(
                                        color: Color(0xff352F44),
                                        fontFamily: 'myfont',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Color(0xffe6f6ff),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '-:  الـمـهـارات الإدراكـيـة -',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myfont',
                            fontSize: 25,
                            fontWeight: FontWeight.w200),
                        textAlign: TextAlign.end,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          for (int i = 0; i < obj2.length; i++)
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      obj2[i]['percentage'] ?? '',
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        color: Color(0xff161A30),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      obj2[i]['object'] ?? '',
                                      style: TextStyle(
                                        color: Color(0xff352F44),
                                        fontFamily: 'myfont',
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Color(0xfffff9e6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '-: الـتـواصـل الـبـصـري -',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myfont',
                            fontSize: 25,
                            fontWeight: FontWeight.w200),
                        textAlign: TextAlign.end,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          for (int i = 0; i < obj3.length; i++)
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      obj3[i]['percentage'] ?? '',
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        color: Color(0xff161A30),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          obj3[i]['object'] ?? '',
                                          style: TextStyle(
                                            color: Color(0xff352F44),
                                            fontFamily: 'myfont',
                                            fontSize: 20,
                                          ),
                                        ),
                                        // Flexible(
                                        //   child: Text(
                                        //     obj3[i]['object'] ?? '',
                                        //     style: TextStyle(
                                        //       color: Color(0xff352F44),
                                        //       fontFamily: 'myfont',
                                        //       fontSize: 20,
                                        //     ),
                                        //     maxLines: 3,
                                        //     overflow: TextOverflow.ellipsis,
                                        //   ),
                                        // ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  color: Color(0xffebffe5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '-: الـمـشـاكـل الـصـحـيـة -',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myfont',
                            fontSize: 25,
                            fontWeight: FontWeight.w200),
                        textAlign: TextAlign.end,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          for (int i = 0; i < obj4.length; i++)
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      obj4[i]['percentage'] ?? '',
                                      style: TextStyle(
                                        fontFamily: 'myfont',
                                        color: Color(0xff161A30),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      obj4[i]['object'] ?? '',
                                      style: TextStyle(
                                        color: Color(0xff352F44),
                                        fontFamily: 'myfont',
                                        fontSize: 20,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}