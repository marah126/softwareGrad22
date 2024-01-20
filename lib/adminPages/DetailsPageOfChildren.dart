
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CardData {
  final String type;
  final String sessionNumber;

  CardData({required this.type, required this.sessionNumber});
}

List<String> yourTableDataList = [
  'Row 1 Data',
  'Row 2 Data',
  'Row 3 Data',
  // Add more rows as needed
];

class DetailsPage extends StatefulWidget {
  final String name;
  
  DetailsPage({required this.name});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final String imageId = '147852369'; // Replace with the actual image ID
  String imageUrl = '';
  String imageID = '';

  late String id;
  late final Map<String,dynamic> ?data ;
  List<dynamic> ?sessions;

  String name="";
  String fp="";
  String mp="";
  String add="";
  String diag="";

  DateTime bd=DateTime.now();
  DateTime ed=DateTime.now();
  DateTime fsd=DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
          id=widget.name;
        });
    print("id"+id);
    getChildInfo();
    getImageUrl();
    getIDImage();
  }

  Future<void> getImageUrl() async {
    print(imageId);
    final String serverUrl = '$ip/sanad/getImage?id=$id';

    try {
      final response = await http.get(Uri.parse(serverUrl));
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          imageUrl = serverUrl;
          print("personal"+imageUrl);
        });
      } else {
        print('Failed to get image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error getting image: $error');
    }
  }

  Future<void> getIDImage() async {
    print(imageId);
    final String serverUrl = '$ip/sanad/getIDImageChild?id=$id';

    try {
      final response = await http.get(Uri.parse(serverUrl));
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          imageID = serverUrl;
          print("image id"+imageID);
        });
      } else {
        print('Failed to get image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error getting image: $error');
    }
  }

  Future<void> getChildInfo() async {
    final response = await http.get(
    Uri.parse(ip + '/sanad/getChildInfoByID?id=$id'),
    );


    if (response.statusCode == 200) {
      print("okkk");
      //print(response.body);
      data = jsonDecode(response.body);
      setState(() {
        name=data!['firstName']+" "+data!['secondName']+" "+data!['thirdName']+" "+data!['lastName'];
        bd=DateTime.parse(data!['birthDate']).toLocal();
        ed=DateTime.parse(data!['enteryDate']).toLocal();
        fsd=DateTime.parse(data!['firstSessionDate']).toLocal();
        fp=data!['fatherPhone'];
        mp=data!['motherPhone'];
        add=data!['address'];
        diag=data!['diagnosis'];
        sessions = data!['sessions'];


      });
      print(bd);
      
    } else {
      print(response.reasonPhrase);
      print("error");
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

  void _showDialog(BuildContext context, String s) {
    List<Map<String, String>> tableData = [
      {"date": "1", "reason": "سـمع ونـطق"},
      {"date": "2", "reason": "علاج سلوكي"},
      {"date": "3", "reason": "علاج وظيفي"},
      {"date": "4", "reason": "رياضة"},
      // Add more rows as needed
    ];
    bool _selectAll = false;
    List<bool> _selectedRows = List.filled(sessions!.length, false);
    void _deleteSelectedRows() {
      List<int> indicesToRemove = [];
      for (int i = 0; i < _selectedRows.length; i++) {
        if (_selectedRows[i]) {
          indicesToRemove.add(i);
        }
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        Size size=MediaQuery.of(context).size;
        return AlertDialog(
          
          content: Container(
            width: size.width*0.75,
            height: size.height*0.4,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
            
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      DataTable(
                        columns: [
                          DataColumn(label: Text("العـدد بالإسـبـوع",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 16),)),
                          DataColumn(label: Text("نـوع الـجـلـسـة",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 16))),
                        ],
                        rows: List.generate(sessions!.length, (index) {
                          return DataRow(
                            cells: [
                              DataCell(Text(sessions![index]['no'].toString(),style: TextStyle(fontFamily: 'myFont',fontSize: 16))),
                              DataCell(Text(sessions![index] ['sessionName'],style: TextStyle(fontFamily: 'myFont',fontSize: 16))),
                            ],
                          );
                        }),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           AnotherPage()), // Navigate to AnotherPage
                            // );
                          },
                          child: Text(
                            'تـعـديـل الـجـلـسـات',
                            style: TextStyle(fontSize: 20,fontFamily: 'myFont'),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF6F35A5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  29), // Optional: for custom shapes
                            ),
                          )),
                    ],
                  ),
                ),
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
                    fontWeight: FontWeight.bold,
                    fontFamily: 'myFont'),
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

  void openphoto(BuildContext context, String imagePath) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Image.asset(
              imagePath,
              width: 100,
              height: 100,
            ),
          );
        });
  }


void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: imageID.isEmpty?Icon(Icons.error):Icon(Icons.done),
          title: Text('صــورة الـــهــويــة',style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20)),
          content: imageID.isEmpty?Text("لــم يــتــم تــحــمــيــل صــورة الــهويــة",
            style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20,color: primaryColor),)
          :Image.network(
            imageID,
            width: 200.0, 
            height: 200.0, 
            fit: BoxFit.cover),
          actions: [
            TextButton(
              
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('إغلاق',style: TextStyle(fontFamily: 'myFont',fontSize: 18,color: primaryColor)),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6f35a5),
        title: Text(
          'تـفــاصـيـل',
          style: TextStyle(fontFamily: 'myfont'),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Positioned(
                        child: Image.asset(
                                'assets/images/tester.png',
                                fit: BoxFit.cover,
                              ),
                     ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 5),
                              Card(
                                color: Colors.transparent,
                                child: Text(name,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'myfont',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),ClipOval(
                                child:imageUrl.isNotEmpty? (Image.network(imageUrl, height: 200.0,width: 200.0,fit: BoxFit.cover,)): 
                                Image.asset('assets/images/profileImage.jpg', width: 200, height: 200,fit: BoxFit.cover,) ,
                              )
                              
                              //  SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 1, 1),
                      child: Column(
                        children: <Widget>[
                          Column(children: <Widget>[
                            Card(
                              //1
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
                              // 2
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Text(DateFormat('yyyy/MM/dd').format(bd),
                                      style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  Spacer(),
                                  Text('   تـاريـخ  الـمـيـلاد ',
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
                              //3
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Text(DateFormat('yyyy/MM/dd').format(ed),
                                      style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  Spacer(),
                                  Text('   تـاريـخ  الـدخـول ',
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
                              //4
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Text(DateFormat('yyyy/MM/dd').format(fsd),
                                      style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  Spacer(),
                                  Text('تـاريـخ  أول جـلـسـة',
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
                              //5
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Text(fp,
                                      style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  Spacer(),
                                  Text('رقـم هـاتـف الأب',
                                      style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.phone,
                                    color: Color.fromARGB(255, 111, 53, 165),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Card(
                              //6
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Text(mp,
                                      style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  Spacer(),
                                  Text(' رقم هـاتـف الأم',
                                      style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.phone,
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
                                  Text(add,
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
                                  Text(diag,
                                      style: TextStyle(
                                          fontFamily: 'myfont',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  Spacer(),
                                  Text(' الـتـشـخـيـص',
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
                            SizedBox(height: 20),
                            Card(
                              //8
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                     // openphoto(context, 'assets/images/id.jpg');
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
                                          borderRadius:
                                              BorderRadius.circular(29.0),
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
                                  Text(' هـويـة الـطـفـل',
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
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFF1E6FF)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(29.0),
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
                                  Text('الـجـلـسـات',
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
                            SizedBox(height: 20),
                            Card(
                              //10
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      //    _openFile();
                                      print('okkkkkk');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFF1E6FF)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(29.0),
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
                                  Text('الـتـقـريـر الـطـبـي',
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
                          ]),
                        ],
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}