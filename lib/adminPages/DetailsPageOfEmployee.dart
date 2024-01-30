// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:sanad_software_project/adminPages/pdf.dart';
import 'package:sanad_software_project/theme.dart';

class spDetailsPage extends StatefulWidget {
  final String name;

  spDetailsPage({required this.name});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<spDetailsPage> {
  // String id = "";

  List<String> vacation = [];
  late final List<dynamic> dataVacation;

  late String id;

  String name = "";
  DateTime startDate = DateTime.now();
  String phone = "";
  String sp = "";
  String idd = "";
  String address = "";
  String imageUrl = '';
  String imageID = ''; 

  @override
  void initState() {
    super.initState();
    setState(() {
      id = widget.name;
    });
    print("id" + id);
    getEmployeeInfo();
    getImageUrl();
    getIDImage();
  }

  Future<void> getEmpVacations() async {
    final EmpVacationsResponse =
        await http.get(Uri.parse(ip + "/sanad/vacations$id"));
    if (EmpVacationsResponse.statusCode == 200) {
      print("okkk");
      print(EmpVacationsResponse.body);
      dataVacation.clear();
      String reason;
      DateTime dateOfVavation = DateTime.now();
      String idd1;
      String count;

      dataVacation = jsonDecode(EmpVacationsResponse.body);
      for (int i = 0; i < dataVacation.length; i++) {
        reason = dataVacation![i]['reason'];
        dateOfVavation =
            DateTime.parse(dataVacation![i]['dateOfVavation']).toLocal();
        // idd1 = dateOfVavation![i]['idd'];
      }
      setState(() {
        // vacation.add(dataVacation);
      });
    } else {
      print("errrrrrrrror");
    }
  }

  Future<void> getEmployeeInfo() async {
    late final Map<String, dynamic>? data;
    final response = await http.get(
      Uri.parse(ip + '/sanad/getSPInfoByID?id=$id'),
    );

    if (response.statusCode == 200) {
      print("okkk");
      print(response.body);
      data = jsonDecode(response.body);
      setState(() {
        name = data!['firstName'] +
            " " +
            data!['secondName'] +
            " " +
            data!['thirdName'] +
            " " +
            data!['lastName'];
        startDate = DateTime.parse(data!['startDate']).toLocal();

        phone = data!['phone'];
        sp = data!['specialise'];
        idd = data!['idd'];
        address = data!['address'];
      });
      //    print(bd);
    } else {
      print(response.reasonPhrase);
      print("error");
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

  Future<void> getIDImage() async {
    print(id);
    final String serverUrl = '$ip/sanad/getJobImageSP?id=$id';

    try {
      final response = await http.get(Uri.parse(serverUrl));
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          imageID = serverUrl;
          print("image id "+imageID);
        });
      } else {
        print('Failed to get image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error getting image: $error');
    }
  }

  Future<void> _openFile() async {
    String filePath = 'files/exp2.pdf';
    OpenResult result = await OpenFile.open(filePath);
    if (result.type == ResultType.done) {
      // File opened successfully
      print('File opened successfully.');
    } else {
      // Handle error if the file can't be opened
      print('Error opening the file: ${result.message}');
    }
  }
void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           icon: imageID.isEmpty?Icon(Icons.error):Icon(Icons.done),
          title: Text('صــورة مزاولـة الــمــهنــة',style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20)),
          content: imageID.isEmpty?Text("لــم يــتــم تــحــمــيــل صــورة الــهويــة",
            style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20,color: primaryColor),):Image.network(
            imageID, // Replace with your image URL
            width: 200.0, // Set the desired width of the image
            height: 200.0, // Set the desired height of the image
            fit: BoxFit.cover)
            // Adjust the BoxFit property as needed
          ,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
void _showCVDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
           icon: imageID.isEmpty?Icon(Icons.error):Icon(Icons.done),
          title: Text(' السيرة الذاتية ',style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20)),
           content: imageID.isEmpty?Text("لــم يــتــم تــحــمــيــل السيرة الذاتية",
            style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20,color: primaryColor),):Image.network(
            imageID, // Replace with your image URL
            width: 200.0, // Set the desired width of the image
            height: 200.0, // Set the desired height of the image
            fit: BoxFit.cover)
          //   // Adjust the BoxFit property as needed
          // content: Image.asset("assets/images/CV.jpeg")
          ,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showDialog(BuildContext context, String s) {
    List<Map<String, String>> tableData = [
      {"date": "20/10/2018", "reason": "مـرضـية"},
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Column(
                children: <Widget>[
                  DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          "  تـاريـخ الإجـازة",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          " سـبـب الإجـازة",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                    rows: [
                      for (var i = 0; i < tableData.length; i++)
                        DataRow(
                          cells: [
                            DataCell(
                              Text(tableData[i]["date"]!,
                                  style: TextStyle(fontSize: 15)),
                            ),
                            DataCell(
                              Text(tableData[i]["reason"]!,
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Card(
                    child: Row(
                      children: <Widget>[
                        Text(" 1",
                            style: TextStyle(
                                fontFamily: 'myfont',
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        SizedBox(width: 90),
                        Text(" عـدد الإجـازات الـكـلـي  ",
                            style: TextStyle(
                                fontFamily: 'myfont',
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Add more Card widgets as needed
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'موافق',
                style: TextStyle(
                    color: Color(0xFF6F35A5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6f35a5),
        title: Text(
          'تـفــاصـيـل',
          style: TextStyle(fontFamily: 'myfont'),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  child: Image.asset(
                    'assets/images/background.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 10,
                  top:40,
                  child:ClipOval(
                                child:imageUrl.isNotEmpty? (Image.network(imageUrl, height: 200.0,width: 200.0,fit: BoxFit.cover,)): 
                                Image.asset('assets/images/profileImage.jpg', width: 200, height: 200,fit: BoxFit.cover,) ,
                              )
                ),
                Container(
                  padding: EdgeInsets.only(right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        children: [
                          SizedBox(height: 30),
                          Card(
                            color: primaryColor,
                            child: Container(
                              width: 170,
                              child: Text(name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'myfont',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            color: primaryColor,
                            child: Text(phone,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'myfont',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            color: primaryColor,
                            child: Text(sp,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'myfont',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                child: Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 1, 1),
              child: Column(
                children: <Widget>[
                  Column(children: <Widget>[
                    // Card(
                    //   color: Colors.white,
                    //   child: Row(
                    //     children: <Widget>[
                    //       Text(id,
                    //           style: TextStyle(
                    //               fontFamily: 'myfont',
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 17)),
                    //       Spacer(),
                    //       Text('الـبريـد الإلكتروني',
                    //           style: TextStyle(
                    //               fontFamily: 'myfont',
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 17)),
                    //       SizedBox(width: 10),
                    //       Icon(
                    //         Icons.email,
                    //         color: Color.fromARGB(255, 111, 53, 165),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    Card(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Text(id,
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          Spacer(),
                          Text(' رقــم الــهـويـة',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          SizedBox(width: 10),
                          Icon(
                            Icons.sd_card,
                            color: Color.fromARGB(255, 111, 53, 165),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      //3
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Text(DateFormat('yyyy/MM/dd').format(startDate),
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          Spacer(),
                          Text('تـاريـخ بــدايــة الـعــمــل',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          SizedBox(width: 10),
                          Icon(
                            Icons.date_range,
                            color: Color.fromARGB(255, 111, 53, 165),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      //7
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Text(address,
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          Spacer(),
                          Text('عـنـوان الـسـكـن',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          SizedBox(width: 10),
                          Icon(
                            Icons.location_pin,
                            color: Color.fromARGB(255, 111, 53, 165),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      //8
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              _showImageDialog(context);
                              print('okkkkkk');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFF1E6FF)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(29.0),
                                ),
                              ),
                            ),
                            child: Text(
                              "  فـتـح الـصـورة",
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          Spacer(),
                          Text('صــورة مـزاولــة الــمـهـنــة',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          SizedBox(width: 10),
                          Icon(
                            Icons.image,
                            color: Color.fromARGB(255, 111, 53, 165),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      //10
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              //    _openFile();
                              // Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => PDFScreen(pdfPath: 'assets/omar.pdf'),
                              //       ),
                              //     );
                              _showCVDialog(context);
                              print('okkkkkk');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFF1E6FF)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(29.0),
                                ),
                              ),
                            ),
                            child: Text(
                              "  فـتـح الـمـلـف",
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          Spacer(),
                          Text('الــسـيـرة الــذاتــيــة',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          SizedBox(width: 10),
                          Icon(
                            Icons.attach_file,
                            color: Color.fromARGB(255, 111, 53, 165),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      //9
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              // print('okkkkkk');
                              //   _showDialog(context, 'ساره حنو');
                              //   DynamicTable();
                              _showDialog(context, 'ساره حنو');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFF1E6FF)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(29.0),
                                ),
                              ),
                            ),
                            child: Text(
                              "الـتـفـاصـيـل ",
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                          Spacer(),
                          Text('الإجــــازات',
                              style: TextStyle(
                                  fontFamily: 'myfont',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17)),
                          SizedBox(width: 10),
                          Icon(
                            Icons.category,
                            color: Color.fromARGB(255, 111, 53, 165),
                          )
                        ],
                      ),
                    ),
                    
                  ]),
                ],
              ),
            )),
          ],
        ),
      ]),
    );
  }
}
