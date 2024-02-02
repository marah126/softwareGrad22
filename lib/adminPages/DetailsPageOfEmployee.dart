// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last

import 'package:dropdown_button2/dropdown_button2.dart';
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
  List<String> years = [''];

  String sickRem = '';
  String yearlyRem = '';
  String shifted = '';
  DateTime selectedDate = DateTime.now();
  String selectedYear = DateTime.now().year.toString();
  late List<Map<String, dynamic>> data = [];
  String nowYear = '';

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
    getVecations();
    getStartYear();
    getDetails();
  }

  Future<void> getVecations() async {
    print("insideeee");
    final allVecationsResponse = await http
        .get(Uri.parse('$ip/sanad/getVecations?id=$id&year=$selectedYear'));
    if (allVecationsResponse.statusCode == 200) {
      //print(jsonDecode(allVecationsResponse.body));
      data = List<Map<String, dynamic>>.from(
          jsonDecode(allVecationsResponse.body));
    } else {
      data = [];
    }
  }
////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> getDetails() async {
    final detailsResponse = await http
        .get(Uri.parse('$ip/sanad/detailes?id=$id&year=$selectedYear'));
    if (detailsResponse.statusCode == 200) {
      print(detailsResponse.body);
      final details = jsonDecode(detailsResponse.body);
      setState(() {
        sickRem = details['sickRemaining'].toString();
        yearlyRem = details['yearlyRemaining'].toString();
        shifted = details['shifted'].toString();
      });
      print(sickRem);
      print(yearlyRem);
      print(shifted);
    }
  }

  // Future<void> getEmpVacations() async {
  //   final EmpVacationsResponse =
  //       await http.get(Uri.parse(ip + "/sanad/vacations$id"));
  //   if (EmpVacationsResponse.statusCode == 200) {
  //     print("okkk");
  //     print(EmpVacationsResponse.body);
  //     dataVacation.clear();
  //     String reason;
  //     DateTime dateOfVavation = DateTime.now();
  //     String idd1;
  //     String count;

  //     dataVacation = jsonDecode(EmpVacationsResponse.body);
  //     for (int i = 0; i < dataVacation.length; i++) {
  //       reason = dataVacation![i]['reason'];
  //       dateOfVavation =
  //           DateTime.parse(dataVacation![i]['dateOfVavation']).toLocal();
  //       // idd1 = dateOfVavation![i]['idd'];
  //     }
  //     setState(() {
  //       // vacation.add(dataVacation);
  //     });
  //   } else {
  //     print("errrrrrrrror");
  //   }
  // }

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
          print("image id " + imageID);
        });
      } else {
        print('Failed to get image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error getting image: $error');
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
          icon: imageID.isEmpty ? Icon(Icons.error) : Icon(Icons.done),
          title: Text('صــورة مزاولـة الــمــهنــة',
              style: TextStyle(
                  fontFamily: 'myFont',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          content: imageID.isEmpty
              ? Text(
                  "لــم يــتــم تــحــمــيــل صــورة الــهويــة",
                  style: TextStyle(
                      fontFamily: 'myFont',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: primaryColor),
                )
              : Image.network(imageID, // Replace with your image URL
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
          icon: imageID.isEmpty ? Icon(Icons.error) : Icon(Icons.done),
          title: Text(' السيرة الذاتية ',
              style: TextStyle(
                  fontFamily: 'myFont',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          content: imageID.isEmpty
              ? Text(
                  "لــم يــتــم تــحــمــيــل السيرة الذاتية",
                  style: TextStyle(
                      fontFamily: 'myFont',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: primaryColor),
                )
              : Image.network(imageID, // Replace with your image URL
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

  // void _showDialog(BuildContext context, String s) {
  //   List<Map<String, String>> tableData = [
  //     {"date": "20/10/2018", "reason": "مـرضـية"},
  //   ];

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       Size size = MediaQuery.of(context).size;
  //       return AlertDialog(
  //         content: SingleChildScrollView(
  //             scrollDirection: Axis.vertical,
  //             child: Padding(
  //                 padding: EdgeInsets.all(3.0),
  //                 child: Column(
  //                   children: <Widget>[
  //                     Row(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           SizedBox(
  //                             width: 20,
  //                           ),
  //                           Container(
  //                               // width: size.width * 0.5,
  //                               child: DropdownButtonHideUnderline(
  //                             child: DropdownButton2<String>(
  //                               isExpanded: true,
  //                               hint: Text(
  //                                 'Select Item',
  //                                 style: TextStyle(
  //                                   fontSize: 14,
  //                                   color: Theme.of(context).hintColor,
  //                                 ),
  //                               ),
  //                               items: years
  //                                   .map((item) => DropdownMenuItem(
  //                                         value: item,
  //                                         child: Text(
  //                                           item,
  //                                           style: const TextStyle(
  //                                               fontSize: 14,
  //                                               fontFamily: 'myFont'),
  //                                         ),
  //                                       ))
  //                                   .toList(),
  //                               value: nowYear,
  //                               onChanged: (value) {
  //                                 setState(() {
  //                                   nowYear = value!;
  //                                   selectedYear = value!;
  //                                   print(selectedYear);
  //                                   getVecations();
  //                                   getDetails();
  //                                 });
  //                               },
  //                               buttonStyleData: ButtonStyleData(
  //                                 height: 50,
  //                                 width: 100,
  //                                 padding: const EdgeInsets.only(
  //                                     left: 14, right: 14),
  //                                 decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(14),
  //                                     border: Border.all(
  //                                         color: primaryColor, width: 2),
  //                                     color: Colors.white),
  //                                 elevation: 2,
  //                               ),
  //                               dropdownStyleData: const DropdownStyleData(
  //                                 maxHeight: 200,
  //                               ),
  //                               menuItemStyleData: const MenuItemStyleData(
  //                                 height: 40,
  //                               ),
  //                             ),
  //                           )),
  //                           SizedBox(
  //                             width: 40,
  //                           ),
  //                           Text('تـفـاصـيـل الإجـازات',
  //                               style: TextStyle(
  //                                   fontFamily: 'myfont',
  //                                   fontSize: 20,
  //                                   fontWeight: FontWeight.bold)),
  //                         ]),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     FutureBuilder(
  //                         future: getVecations(),
  //                         builder: (context, snapshot) {
  //                           if (snapshot.connectionState ==
  //                               ConnectionState.waiting) {
  //                             return CircularProgressIndicator(); // Show a loading indicator
  //                           } else if (snapshot.hasError) {
  //                             return Text('Error: ${snapshot.error}');
  //                           } else {
  //                             // Continue building your UI with the fetched data
  //                             return Container(
  //                               padding: EdgeInsets.symmetric(horizontal: 0),
  //                               child: DataTable(
  //                                 decoration: BoxDecoration(
  //                                   color: Color(0xFFF1E6FF),
  //                                 ),
  //                                 border: TableBorder.all(
  //                                   color: Color(0xff6f35a5),
  //                                 ),
  //                                 columns: [
  //                                   DataColumn(
  //                                       label: Text(
  //                                     ' انتهاء الإجازة',
  //                                     style: TextStyle(
  //                                         fontFamily: 'myfont', fontSize: 18),
  //                                     // textAlign: TextAlign.center
  //                                   )),
  //                                   DataColumn(
  //                                       label: Text(
  //                                     ' بدء الإجازة',
  //                                     style: TextStyle(
  //                                         fontFamily: 'myfont', fontSize: 18),
  //                                     // textAlign: TextAlign.center
  //                                   )),
  //                                   DataColumn(
  //                                       label: Text(
  //                                     'نوع الإجازة',
  //                                     style: TextStyle(
  //                                         fontFamily: 'myfont', fontSize: 18),
  //                                     //textAlign: TextAlign.center
  //                                   )),
  //                                 ],
  //                                 rows:
  //                                     data.map((Map<String, dynamic> rowData) {
  //                                   return DataRow(
  //                                     cells: [
  //                                       DataCell(Text(
  //                                         formateDate(rowData['endDate'] ?? ''),
  //                                         style: TextStyle(
  //                                             fontFamily: 'myfont',
  //                                             fontSize: 18),
  //                                       )),
  //                                       DataCell(Text(
  //                                         formateDate(
  //                                             rowData['startDate'] ?? ''),
  //                                         style: TextStyle(
  //                                             fontFamily: 'myfont',
  //                                             fontSize: 18),
  //                                       )),
  //                                       DataCell(Text(
  //                                         rowData['type'] ?? '',
  //                                         style: TextStyle(
  //                                             fontFamily: 'myfont',
  //                                             fontSize: 18),
  //                                       )),
  //                                     ],
  //                                   );
  //                                 }).toList(),
  //                               ),
  //                             );
  //                           }
  //                         }),
  //                     SizedBox(
  //                       height: 50,
  //                     ),
  //                     Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: <Widget>[
  //                           Text(
  //                             sickRem,
  //                             style: TextStyle(
  //                                 fontFamily: 'myfont',
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                           Text(
  //                             ' الإجـازات الـمــرضــيــة الـمتــبــقـيــة',
  //                             style: TextStyle(
  //                                 fontFamily: 'myfont',
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.w100),
  //                           ),
  //                         ]),
  //                     Divider(
  //                       height: 1.0,
  //                       thickness: 1.0,
  //                       color: Color(0xff6f35a5),
  //                       indent: 50.0, // Set the starting padding
  //                       endIndent: 50.0, // Set the ending padding
  //                     ),
  //                     SizedBox(height: 5),
  //                     Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: <Widget>[
  //                           Text(
  //                             yearlyRem,
  //                             style: TextStyle(
  //                                 fontFamily: 'myfont',
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                           Text(
  //                             ' الإجـازات الـســنـويــة الـمتـبـقــيــة ',
  //                             style: TextStyle(
  //                                 fontFamily: 'myfont',
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.w100),
  //                           ),
  //                         ]),
  //                     Divider(
  //                       height: 1.0,
  //                       thickness: 1.0,
  //                       color: Color(0xff6f35a5),
  //                       indent: 50.0,
  //                       endIndent: 50.0,
  //                     ),
  //                     SizedBox(height: 5),
  //                     Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: <Widget>[
  //                           Text(
  //                             shifted,
  //                             style: TextStyle(
  //                                 fontFamily: 'myfont',
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                           Text(
  //                             'عـــدد الإجـــازات الـــمــــرحـــلــة',
  //                             style: TextStyle(
  //                                 fontFamily: 'myfont',
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.w100),
  //                           ),
  //                         ]),
  //                     Divider(
  //                       height: 1.0,
  //                       thickness: 1.0,
  //                       color: Color(0xff6f35a5),
  //                       indent: 50.0, // Set the starting padding
  //                       endIndent: 50.0, // Set the ending padding
  //                     ),
  //                     SizedBox(
  //                       height: 50,
  //                     )
  //                   ],
  //                 ))),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text(
  //               'موافق',
  //               style: TextStyle(
  //                   color: Color(0xFF6F35A5),
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
                    top: 40,
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
                    )),
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
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
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
                       SizedBox(height: 10),
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                                // _showDialog(context, 'ساره حنو');
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                // width: size.width * 0.5,
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
                                                fontSize: 14,
                                                fontFamily: 'myFont'),
                                          ),
                                        ))
                                    .toList(),
                                value: nowYear,
                                onChanged: (value) {
                                  setState(() {
                                    nowYear = value!;
                                    selectedYear = value!;
                                    print(selectedYear);
                                    getVecations();
                                    getDetails();
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 100,
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
                            SizedBox(
                              width: 40,
                            ),
                            Text('تـفـاصـيـل الإجـازات',
                                style: TextStyle(
                                    fontFamily: 'myfont',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ]),
                      SizedBox(
                        height: 20,
                      ),
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
                                  rows:
                                      data.map((Map<String, dynamic> rowData) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(
                                          formateDate(rowData['endDate'] ?? ''),
                                          style: TextStyle(
                                              fontFamily: 'myfont',
                                              fontSize: 18),
                                        )),
                                        DataCell(Text(
                                          formateDate(
                                              rowData['startDate'] ?? ''),
                                          style: TextStyle(
                                              fontFamily: 'myfont',
                                              fontSize: 18),
                                        )),
                                        DataCell(Text(
                                          rowData['type'] ?? '',
                                          style: TextStyle(
                                              fontFamily: 'myfont',
                                              fontSize: 18),
                                        )),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              );
                            }
                          }),
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
                ],
              ),
            )),
          ],
        ),
      ]),
    );
  }
}
