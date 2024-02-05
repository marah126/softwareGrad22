// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sanad_software_project/specialestPages/objectives.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;

class evalobjec extends StatefulWidget {
  @override
  _evalobjecState createState() => _evalobjecState();
}

class _evalobjecState extends State<evalobjec> {
  String childID = '123456789';
  String spID = '987654321';
  bool isChecked = false;
  String itemm = myItems.first;
  static List<String> myItems = [
    'التركيز والانتباه',
    'المهارات الإدراكية',
    'التواصل البصري',
    'المشاكل الصحية'
  ];

  List<String> goalsList = [];
  List<String> percentList = [];
  

  List<bool> isCheckedList = [];

  Future<void> getGoals(String subType) async {
    setState(() {
      goalsList.clear();
      percentList.clear();
      isCheckedList.clear();
    });

    try {
      final goalsResponse = await http.get(Uri.parse(
          "$ip/sanad/getObjects?childID=$childID&spID=$spID&type=وظيفي&subType=$subType"));
      if (goalsResponse.statusCode == 200) {
        List<dynamic> data = jsonDecode(goalsResponse.body);
        for (int i = 0; i < data.length; i++) {
          setState(() {
            String text = data[i]['object'];
            goalsList.add(text);
            String percent = data[i]['percent'];
            percentList.add(percent);
            isCheckedList.add(false);
          });
        }
      }
    } catch (error) {
      print("error $error");
    }
  }

  Future<void> update() async {
    try {
      for (int i = 0; i < goalsList.length; i++) {
        if (isCheckedList[i] == true) {
          print("index $i");
          print(goalsList[i]);
          print(percentList[i]);
          final updateDone =
              await http.post(Uri.parse("$ip/sanad/updateObjStatus"), body: {
            'childID': childID,
            'spID': spID,
            'type': "وظيفي",
            'subType': itemm,
            'object': goalsList[i].trim(),
            'percent': percentList[i].trim(),
          });
          if (updateDone.statusCode == 200) {
            print("updated");
          } else {
            print("noo update");
          }
        }
      }
    } catch (error) {
      print("error $error");
    }
  }

  @override
  void initState() {
    super.initState();
    getGoals("التركيز والانتباه ");
    print(goalsList.length);
  }

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
          color: Color(0xffFAF5FF),
          padding: EdgeInsets.symmetric(horizontal: 8),
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  Text(
                    'العـلاج الـوظـيـفـي',
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'myfont',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "مها دريني",
                        style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 20,
                            color: secondaryColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(": الــطــفــل",
                          style: TextStyle(
                              fontFamily: 'myFont',
                              fontSize: 20,
                              color: secondaryColor))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: myItems
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 14, fontFamily: 'myFont'),
                                    ),
                                  ))
                              .toList(),
                          value: itemm,
                          onChanged: (value) {
                            setState(() {
                              itemm = value!;
                              getGoals(itemm);
                              //ss = value!;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 50,
                            width: 160,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border:
                                    Border.all(color: primaryColor, width: 2),
                                color: Colors.white),
                            elevation: 2,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "اخـــتـــر الــمــهــارة ",
                        style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 20,
                            color: secondaryColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // for(int j=0;j<3;j++)
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    color: Color(0xffFAF5FF),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            itemm,
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'myfont',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              goalsList.isEmpty
                                  ? Text("لا يوجد اهداف",
                                      style: TextStyle(
                                          fontFamily: 'myFont',
                                          fontSize: 20,
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold))
                                  : SizedBox(),
                              for (int i = 0; i < goalsList.length; i++)
                                Card(
                                  margin: EdgeInsets.only(bottom: 20),
                                  color: primaryLightColor,
                                  elevation: 2,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "${percentList[i]}%" ?? '',
                                            style: TextStyle(
                                              fontFamily: 'myfont',
                                              color: Color(0xff161A30),
                                              fontSize: 20,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width:
                                                300, // Replace maxWidth with the maximum width you want to allow
                                            child: Text(
                                              goalsList[i] ?? '',
                                              style: TextStyle(
                                                color: Color(0xff352F44),
                                                fontFamily: 'myfont',
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.right,
                                              maxLines:
                                                  10, // Adjust the number of lines as needed
                                              overflow: TextOverflow
                                                  .ellipsis, // Handle overflow by displaying ellipsis
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Spacer(),
                                          Checkbox(
                                            value: isCheckedList[i],
                                            onChanged: (value) {
                                              setState(() {
                                                isCheckedList[i] = value!;
                                              });
                                            },
                                            activeColor: primaryColor,
                                            checkColor: Colors.white,
                                          ),
                                          Spacer(),
                                          Text(
                                            'تـم تـحـقـيـق الـهـدف',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 40, 34, 55),
                                              fontFamily: 'myfont',
                                              fontSize: 17,
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      // Divider(thickness: 0.8,color: Colors.grey,)
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text(
                  "حـــفـــظ",
                  style: TextStyle(
                      fontFamily: 'myFont',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                onPressed: () {
                  update();
                  getGoals(itemm);
                },
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          )),
    );
  }
}
