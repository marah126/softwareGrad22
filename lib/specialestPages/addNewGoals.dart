// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sanad_software_project/components/roundedTextFeild2.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;

class newGoals extends StatefulWidget {
  final String childId;
  final String spId;

  const newGoals({super.key, required this.childId, required this.spId});
  @override
  _newGoalsState createState() => _newGoalsState();
}

class _newGoalsState extends State<newGoals> {
  String childID = "";
  String spId = "";
  String name='';
  List<String> selectedValues = [];
  static List<String> myItems = [
    'التركيز والانتباه ',
    'المهارات الإدراكية ',
    'التواصل البصري ',
    'المشاكل الصحية '
  ];
  String s = myItems.first;
  List<Widget> goalCards = [];
  List<TextEditingController> controllerList = [];
  List<TextEditingController> percentcontrollerList = [];
  List <bool> enable=[];

  int index = 0;

  void func() {
    if (goalCards.isEmpty) {
      print("hi");
     
    } else {
      print("hhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiii");
      for (int i = 0; i < goalCards.length; i++) {
        print(controllerList[i].text);
        print(percentcontrollerList[i].text);
      }
    }
  }

  Future<void> postnewGoals(String text,String percent,String selected,int i) async {
    bool check = false;
    try {
      
        if (text.trim().isEmpty) {
          check = true;
        }
      
      if (check) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                icon: Icon(
                  Icons.warning,
                  color: primaryColor,
                ),
                content: Text(
                  " يـرجـى تــعـبـئـة  الــهــدف الـذي قــمــت بـإضـافـتـه",
                  style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              );
            });
            return;
      }
      
        final newOB = await http.post(Uri.parse("$ip/sanad/newObject"), body: {
          'childID': childID,
          'spID': spId,
          'type': "وظيفي",
          'subType': selected.trim(),
          'object': text.trim(),
          'percent': percent.trim(),
        });
        if (newOB.statusCode == 200) {
          print("done ");
           setState(() {
           enable[i] = false;
      });
        }
    } catch (error) {
      print("error $error");
    }
  }
  Future<void> getSPname()async{
    print("4444 $childID");
  final spName = await http.get(Uri.parse("$ip/sanad/getChildname?id=$childID"));
  if(spName.statusCode==200){
    print("body "+spName.body.toString());
    final spNameBody=jsonDecode(spName.body);
    setState(() {
      name=spNameBody['Fname']+" "+spNameBody['Lname'];
    });
    
    print("name"+name);
  }
  else{
    print("error"+spName.body);
  }
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      childID=widget.childId;
      spId=widget.spId;
    });
    getSPname();
    TextEditingController newController = TextEditingController();
    TextEditingController percentController = TextEditingController();
    String selected = myItems.first;
    bool e=true;
    enable.add(e);
    selectedValues.add(selected);
    controllerList.add(newController);
    percentcontrollerList.add(percentController);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          " إضـافـة أهـداف جـديـدة",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'myFont',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: size.width,
        height: size.height,
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
            SizedBox(height: 10),
            Expanded(
              child: Column(
                children: [
                  // ...goalCards,
                  // if (goalCards.isEmpty)
                  Expanded(
                    child: ListView.builder(
                        itemCount: controllerList.length,
                        itemBuilder: (context, indexx) {
                          print(controllerList.length);

                          return Card(
                            elevation: 5,
                            color: primaryLightColor,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: selectedValues[indexx],
                                            items: myItems.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                    fontFamily: 'myfont',
                                                    color: Color(0xff161A30),
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedValues[indexx] = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'إضـافـة هـدف إلـى',
                                        style: TextStyle(
                                          fontFamily: 'myfont',
                                          color: Color(0xff161A30),
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      RoundedTextField2(
                                        width: 120,
                                        child: TextField(
                                          controller:
                                              percentcontrollerList[indexx],
                                          textAlign: TextAlign.right,
                                          decoration: InputDecoration(
                                            hintText: 'الـنـسـبـة',
                                            hintStyle:
                                                TextStyle(fontFamily: 'myFont'),
                                            suffixText: '%',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      RoundedTextField2(
                                        width: 250,
                                        child: TextField(
                                          textAlign: TextAlign.right,
                                          controller: controllerList[indexx],
                                          decoration: InputDecoration(
                                            hintText: 'الـهـدف',
                                            hintStyle:
                                                TextStyle(fontFamily: 'myFont'),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: Text("حـــفـــظ",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 16),),
                                    onPressed: enable[indexx]
                                        ? () {
                                            postnewGoals(controllerList[indexx].text,percentcontrollerList[indexx].text,selectedValues[indexx],indexx);
                                          }
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            // SizedBox(height: 20),
            Container(
              child: RoundedButton(
                color: primaryColor,
                text: "إضـافـة هـدف جـديـد",
                textColor: Colors.white,
                press: () {
                  addNewGoalCard();
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   width: size.width*0.8,
            //     child: ElevatedButton(
                  
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: primaryColor,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20.0),
            //     ),
            //   ),
            //   child: Text("save"),
            //   onPressed: () {
            //   //  postnewGoals();
            //   },
            // )),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void addNewGoalCard() {
    print(index);
    TextEditingController newController = TextEditingController();
    TextEditingController percentController = TextEditingController();
    bool e=true;
    String selected = "";
    setState(() {
      index++;
      selected = myItems.first;
      enable.add(e);
      selectedValues.add(selected);
      controllerList.add(newController);
      percentcontrollerList.add(percentController);
    });
  }
}
