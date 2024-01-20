// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanad_software_project/notification.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;

class vications extends StatefulWidget {
  final String id;

  const vications({super.key, required this.id});
  @override
  State<StatefulWidget> createState() {
    return _vicationsState();
  }
}

class _vicationsState extends State<vications> {
  late String id;
  static List<String> type = [
    'مرضية',
    'سنوية',
    'أمومة',
  ];
  String nowYear='';
  List<String> years=[''];
  String selectedType = type.first;
  // List<Map<String, String>> tableData = [
  //   {"stsrtdate": "20/10/2018", "endDate": "1/1/2024", "reason": "مـرضـية"},
  //   {"stsrtdate": "16/03/2019", "endDate": "1/1/2024", "reason": "مـرضـية"},
  //   {"stsrtdate": "20/10/2018", "endDate": "1/1/2024", "reason": "مـرضـية"},
  //   {"stsrtdate": "16/03/2019", "endDate": "1/1/2024", "reason": "مـرضـية"},
  // ];
  DateTime StartDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String sd = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String ed = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final TextEditingController reasonController = TextEditingController();

  bool date1 = false;
  bool date2 = false;
  bool checked = false;

   String sickRem='';
   String yearlyRem='';
   String shifted='';

  DateTime selectedDate = DateTime.now();
  String selectedYear=DateTime.now().year.toString();
  late List<Map<String, dynamic>> data = [];
  

  Future<void> postNewVecation() async {
    final newVecationResponse =
        await http.post(Uri.parse(ip + "/sanad/newVecation"), body: {
      'id': id,
      'reason': reasonController.text,
      'type': selectedType,
      'startDate': sd,
      'endDate': ed
    });
    if (newVecationResponse.statusCode == 200) {
      print("Done");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "نــجــاح",
                style: TextStyle(
                    fontFamily: 'myFont',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              icon: Icon(
                Icons.done,
                color: Colors.green,
              ),
              content: Text(
                "تــم طــلــب إجــازة بــنــجــاح",
                style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                textAlign: TextAlign.left,
              ),
            );
          });
    }
  }


 Future<void> getStartYear()async{
  final startYearRes = await http.get(Uri.parse("$ip/sanad/enteredYear?id=$id"));
  if(startYearRes.statusCode==200){
    print(startYearRes.body);

    String y=startYearRes.body;
    int yy= int.parse(y);

    years=[];

    int count=DateTime.now().year - int.parse(startYearRes.body);
    for(int i=0; i<=count ; i++){
      y=yy.toString();
      years.add(y);
      yy++;

    }
    nowYear=years.last;

    for(int i=0;i<years.length;i++){
      print(years[i]);
    }

  }
 }

  void checkPost() {
    if (reasonController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "تــحــذيــر",
                style: TextStyle(
                    fontFamily: 'myFont',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              icon: Icon(
                Icons.error,
                color: Colors.red,
              ),
              content: Text(
                "يــجــب تــعــبــئــة ســبــب الإجــازة",
                style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                textAlign: TextAlign.left,
              ),
            );
          });
    } else {
      checked = true;
    }
  }


 Future<void> getVecations() async {
    print("insideeee");
    final allVecationsResponse =
        await http.get(Uri.parse('$ip/sanad/getVecations?id=$id&year=$selectedYear'));
    if (allVecationsResponse.statusCode == 200) {
      //print(jsonDecode(allVecationsResponse.body));
      data = List<Map<String, dynamic>>.from(
          jsonDecode(allVecationsResponse.body));
    }
    else{
      data=[];
    }
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void>getDetails()async{
    final detailsResponse =
        await http.get(Uri.parse('$ip/sanad/detailes?id=$id&year=$selectedYear'));
    if(detailsResponse.statusCode==200){
      print(detailsResponse.body);
      final details=jsonDecode(detailsResponse.body);
      setState(() {
        sickRem=details['sickRemaining'].toString();
        yearlyRem=details['yearlyRemaining'].toString();
        shifted=details['shifted'].toString();
      });
      print(sickRem);
      print(yearlyRem);
      print(shifted);
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
    print("vecations id"+id);
    print("yeaarrrr"+selectedYear);
    getVecations();
    getStartYear();
    getDetails();
  }

  Future<void> _selectDate(BuildContext context, int pickerNumber) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff6f35a5),
            hintColor: Color(0xff6f35a5),
            colorScheme: ColorScheme.light(primary: Color(0xff6f35a5)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        switch (pickerNumber) {
          case 1:
            setState(() {
              StartDate = picked;
              sd = DateFormat('yyyy-MM-dd').format(StartDate);
              date1 = true;
            });
            break;
          case 2:
            setState(() {
              endDate = picked;
              ed = DateFormat('yyyy-MM-dd').format(endDate);
              date2 = true;
            });
            break;
        }
      });
    }
  }

 
  String formateDate(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      // Handle parsing error, return original string or any default value
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
      pushNotificationsManager.initInfo(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6f35a5),
        title: Text(
          'الإجـازات',
          style: TextStyle(fontFamily: 'myfont'),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  width: size.width * 0.98,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(width: 10),
                          Center(
                            child: Text(
                              'تـقـديـم طـلـب إجـازة ',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  color: Color(0xff6f35a5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            'سـبـب الإجـازة    ',
                            style:
                                TextStyle(fontFamily: 'myfont', fontSize: 20),
                          ),
                          TextField(
                            controller: reasonController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              labelText: ' ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(29.0),
                                borderSide: BorderSide(
                                    //  color: Color(0xff6f35a5),
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              Container(
                                  //width: size.width * 0.5,
                                  child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: type
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'myFont'),
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedType,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedType = value!;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: 160,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                            color: primaryColor, width: 2),
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
                              )),
                              Spacer(),
                              Text("نــوع الإجـــازة",
                                  style: TextStyle(
                                      fontFamily: 'myfont', fontSize: 20)),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'تـاريـخ بــدء الإجـازة',
                            style:
                                TextStyle(fontFamily: 'myfont', fontSize: 20),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      _selectDate(context, 1);
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff6f35a5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                child: Icon(Icons.calendar_month),
                              ),
                              Spacer(),
                              Text(
                                sd,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 40,
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'تـاريـخ انــتــهـــاء الإجـازة',
                            style:
                                TextStyle(fontFamily: 'myfont', fontSize: 20),
                          ),
                          Row(
                            //  mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () => _selectDate(context, 2),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff6f35a5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                child: Icon(Icons.calendar_month),
                              ),
                              Spacer(),
                              Text(
                                ed,
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 40,
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: ()async {
                                checkPost();
                                if (checked) {
                                  postNewVecation();
                                  DocumentSnapshot snap=await FirebaseFirestore.instance.collection("notifications").doc(id).get();
                                  String token=snap['token'];
                                  print(token);
                                  print(id);
                                  pushNotificationsManager.sendPushMessage(token, "vecation", "vecation Body");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff6f35a5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: Text(
                                'تـأكـيـد الـطـلـب',
                                style: TextStyle(
                                    fontFamily: 'myfont', fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(height: 20),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      //width: size.width * 0.5,
                      child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: years
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontSize: 14, fontFamily: 'myFont'),
                                ),
                              ))
                          .toList(),
                      value: nowYear,
                      onChanged: (value) {
                        setState(() {
                          nowYear = value!;
                          selectedYear=value!;
                          print(selectedYear);
                          getVecations();
                          getDetails();
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 100,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: primaryColor, width: 2),
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
                  )),
                  SizedBox(
                    width: 40,
                  ),
                  Text('تـفـاصـيـل الإجـازات',
                      style: TextStyle(
                          fontFamily: 'myfont',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ]),
              SizedBox(height: 20,),
                FutureBuilder(
                      future: getVecations(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Show a loading indicator
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Continue building your UI with the fetched data
                          return Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: DataTable(
                            decoration: BoxDecoration(
                              color: Color(0xFFF1E6FF),
                            ),
                            border: TableBorder.all(
                              color: Color(0xff6f35a5),
                            ),
                            columns: [
                              DataColumn(
                                  label: Text(
                                ' انتهاء الإجازة',
                                style: TextStyle(
                                    fontFamily: 'myfont', fontSize: 18),
                                // textAlign: TextAlign.center
                              )),
                              DataColumn(
                                  label: Text(
                                ' بدء الإجازة',
                                style: TextStyle(
                                    fontFamily: 'myfont', fontSize: 18),
                                // textAlign: TextAlign.center
                              )),
                              DataColumn(
                                  label: Text(
                                'نوع الإجازة',
                                style: TextStyle(
                                    fontFamily: 'myfont', fontSize: 18),
                                //textAlign: TextAlign.center
                              )),
                            ],
                            rows: data.map((Map<String, dynamic> rowData) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(
                                    formateDate(rowData['endDate'] ?? ''),
                                    style: TextStyle(
                                        fontFamily: 'myfont', fontSize: 18),
                                  )),
                                  DataCell(Text(
                                    formateDate(rowData['startDate'] ?? ''),
                                    style: TextStyle(
                                        fontFamily: 'myfont', fontSize: 18),
                                  )),
                                  DataCell(Text(
                                    rowData['type'] ?? '',
                                    style: TextStyle(
                                        fontFamily: 'myfont', fontSize: 18),
                                  )),
                                ],
                              );
                            }).toList(),
                          )
                        
                      ,
                );
                        }}
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        sickRem,
                        style: TextStyle(
                            fontFamily: 'myfont',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' الإجـازات الـمــرضــيــة الـمتــبــقـيــة',
                        style: TextStyle(
                            fontFamily: 'myfont',
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                    ]),
                Divider(
                  height: 1.0,
                  thickness: 1.0,
                  color: Color(0xff6f35a5),
                  indent: 50.0, // Set the starting padding
                  endIndent: 50.0, // Set the ending padding
                ),
                SizedBox(height: 5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        yearlyRem,
                        style: TextStyle(
                            fontFamily: 'myfont',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' الإجـازات الـســنـويــة الـمتـبـقــيــة ',
                        style: TextStyle(
                            fontFamily: 'myfont',
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                    ]),
                Divider(
                  height: 1.0,
                  thickness: 1.0,
                  color: Color(0xff6f35a5),
                  indent: 50.0,
                  endIndent: 50.0,
                ),
                SizedBox(height: 5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        shifted,
                        style: TextStyle(
                            fontFamily: 'myfont',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'عـــدد الإجـــازات الـــمــــرحـــلــة',
                        style: TextStyle(
                            fontFamily: 'myfont',
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                    ]),
                Divider(
                  height: 1.0,
                  thickness: 1.0,
                  color: Color(0xff6f35a5),
                  indent: 50.0, // Set the starting padding
                  endIndent: 50.0, // Set the ending padding
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
