// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sanad_software_project/theme.dart';
import 'DetailsPageOfChildren.dart';

class viewChildren extends StatefulWidget {
  @override
  _viewChidrenState createState() => _viewChidrenState();
}

class _viewChidrenState extends State<viewChildren> {
  bool visable = false;

  String selectedValue = options.first;
  static List<String> options = [
    'التشخيص',
    'سنة الدخول',
    'سنة الميلاد',
    'الجلسة',
  ];
   String selectedValue1 = options1.first;
  static List<String> options1 = [
    'مـتلازمـة داون',
    'تـوحـد',
    'صـعوبـة فـي الـتـعلـم',
  ];
  late String selectedValue2 ;
   List<String> options2 = [];
  late String selectedValue3 ;
   List<String> options3 = [];
  String selectedValue6 = options6.first;
  static const List<String> options6 = [
    'سلوكي',
    'وظيفي',
    'تربية خاصة',
    'علاج طبيعي',
    'اللغة و النطق ',
  ];
  late String svalue;
  List<String> soptions = [
    '-----',
  ];
  String id = "";
  List<String> children = [];
  // String img = 'assets/images/child1.png';
   List<dynamic> data=[];
  // late final List<dynamic> image ;
  List<String> imagePath = [];
  List<String> imageID = [];
  //List<ImageDetails> imageDetailsList = [];

  String searchBy="";
  String value2="";

  List <String>idd=[];

  void initYear(){
    int y=DateTime.now().year;
    String yy=y.toString();
    while(y!=2000){
      options2.add(yy);
      options3.add(yy);
      y--;
      yy=y.toString();
    }

  }

  Future<void> filter()async{
    print("search by $searchBy");
    final response=await http.get(Uri.parse("$ip/sanad/filterChildren?searchBy=$searchBy&value=$value2"));
    if(response.statusCode==200){
      children.clear();
      idd.clear();
      String childName;
      data = jsonDecode(response.body);

      for (int i = 0; i < data.length; i++) {
        print(data[i]['firstName'] + " " + data[i]['lastName']);
        childName = data[i]['firstName'] + " " + data[i]['lastName'];
        setState(() {
          children.add(childName);
          idd.add(data[i]['idd']);
        });
      }
      
    } else if (response.statusCode == 404) {
      print("errrrrrrrror");
      setState(() {
        children.clear();
      });
      
    }
    
  }

  Future<void> getChildrenImages() async {
    String path;
    String id;
    final images = await http.get(Uri.parse(ip + "/sanad/getAllImages"));
    if (images.statusCode == 200) {
      print(images.body);
      final List<dynamic> image = jsonDecode(images.body);
      for (int i = 0; i < image.length; i++) {
        path = image[i]['path'];
        id = image[i]['childID'];
        print(path);
        print(id);
        imagePath.add(path);
        imageID.add(id);
      }
    }
  }

// Future<void> fetchImageDetails() async {
//     final String serverUrl = 'http://192.168.1.19:3000/sanad/getAllImages';

//     try {
//       final response = await http.get(Uri.parse(serverUrl));

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);
//         final List<dynamic> images = data['images'];

//         setState(() {
//           imageDetailsList = images
//               .map((image) => ImageDetails(id: image['id'], path: image['path']))
//               .toList();
//         });
//       } else {
//         print('Failed to get image details. Status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error getting image details: $error');
//     }
//   }

  Future<void> getChildrenNames() async {
    print("childrenssssssssssss");
    final childreNamesResponse =
        await http.get(Uri.parse(ip + "/sanad/getchname"));
    if (childreNamesResponse.statusCode == 200) {
      print(childreNamesResponse.body);
      children.clear();
      idd.clear();
      String childName;
      data = jsonDecode(childreNamesResponse.body);

      for (int i = 0; i < data.length; i++) {
        print(data[i]['Fname'] + " " + data[i]['Lname']);
        childName = data[i]['Fname'] + " " + data[i]['Lname'];
        setState(() {
          children.add(childName);
          idd.add(data[i]['id']);
        });
      }
      for (int i = 0; i < children.length; i++) {
        print("ch" + children[i]);
      }
    } else if (childreNamesResponse.statusCode == 404) {
      print("errrrrrrrror");
    }
  }

  @override
  void initState() {
    super.initState();
    initYear();
    soptions=options;
    svalue=soptions.first;
    getChildrenNames();
    getChildrenImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6f35a5),
        automaticallyImplyLeading: false,
        title: Text(
          "الأطــــفـــال",
          style: TextStyle(
              fontFamily: 'myFont', fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      DropdownButton<String>(
                            value: svalue,
                            items: soptions.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      fontSize: 16.0, fontFamily: 'myFont'),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                svalue = newValue!;
                                visable = true;
                                value2=newValue!;
                              });
                            },
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 19.0,
                            ),
                            dropdownColor: Colors.grey[200],
                            elevation: 4,
                          ),
                          SizedBox(width: 20,),
                      DropdownButton<String>(
                        value: selectedValue,
                        items: options.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            // soptions = ['-----'];

                            if (newValue == 'التشخيص') {
                              soptions = options1;
                              searchBy="sick";
                            } else if (newValue == 'سنة الدخول') {
                              soptions = options2;
                              searchBy="enteredYear";
                            } else if (newValue == 'سنة الميلاد') {
                              soptions = options3;
                              searchBy="birthYear";
                            } else if (newValue == 'الجلسة') {
                              soptions = options6;
                              searchBy="sessions";
                            }
                            svalue=soptions.first;
                          });
                        },
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 19.0,
                            
                            fontFamily: 'myFont'),
                        dropdownColor: Colors.grey[200],
                        elevation: 2,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'الـبـحـث حـسـب',
                        style: TextStyle(
                          fontFamily: 'myfont',
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Icon(
                        Icons.filter_list,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                  SizedBox(height: 10,),
                   ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () async {
                          await filter();
                        },
                          
                        child: Text(
                          "ابـــحــــث",
                          style: TextStyle(
                              fontFamily: 'myFont',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        )),
                  Divider(
                    thickness: 0.8,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 15),
                  
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          /////////////////////////////////////////////////
          //show just what i need
          Visibility(
            visible: true,
            child: Expanded(
              child: ListView.builder(
                itemCount: children.length,
                itemBuilder: (context, index) {
                  String registered_child = children[index];
                  return Card(
                    margin: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                print(imagePath[
                                    imageID.indexOf(idd[index])]);
                                id = idd[index];
                                print(index);
                                print(id);
                                _onPressed(context, id);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF6F35A5)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(29.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                "كـافـة الـتـفـاصـيـل",
                                style: TextStyle(fontFamily: 'myfont'),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          registered_child,
                          style: TextStyle(fontSize: 18, fontFamily: 'myfont'),
                        ),
                        Spacer(),
                        ClipOval(
                          child: imageID.contains(idd[index])
                              ? Image.network(
                                  'http://192.168.1.19:3000/sanad/getImage?id=${imageID[imageID.indexOf(idd[index])]}',
                                  width: 70,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/profileImage.jpg',
                                  width: 70,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          /////////////////////////////////
          ///// show all employee when the page load
          Visibility(
            visible: false,
            child: Expanded(
              child: ListView.builder(
                itemCount: children.length,
                itemBuilder: (context, index) {
                  String registered_child = children[index];
                  return Card(
                    margin: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                print(imagePath[
                                    imageID.indexOf(data[index]['id'])]);
                                id = data[index]['id'];
                                print(index);
                                print(id);
                                _onPressed(context, id);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF6F35A5)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(29.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                "كـافـة الـتـفـاصـيـل",
                                style: TextStyle(fontFamily: 'myfont'),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          registered_child,
                          style: TextStyle(fontSize: 18, fontFamily: 'myfont'),
                        ),
                        Spacer(),
                        ClipOval(
                          child: imageID.contains(data[index]['idd'])
                              ? Image.network(
                                  'http://192.168.1.19:3000/sanad/getImage?id=${imageID[imageID.indexOf(data[index]['idd'])]}',
                                  width: 70,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/profileImage.jpg',
                                  width: 70,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      // ListView.builder(
      //   itemCount: children.length,
      //   itemBuilder: (context, index) {
      //     String registered_child = children[index];
      //     return Card(
      //       margin: EdgeInsets.all(16),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: <Widget>[
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: <Widget>[
      //               ElevatedButton(
      //                 onPressed: () {
      //                   print(imagePath[imageID.indexOf(data[index]['id'])]);
      //                   id=data[index]['id'];
      //                   print(index);
      //                   print(id);
      //                   _onPressed(context, id);
      //                 },
      //                 style: ButtonStyle(
      //                   backgroundColor:
      //                       MaterialStateProperty.all<Color>(Color(0xFF6F35A5)),
      //                   shape:
      //                       MaterialStateProperty.all<RoundedRectangleBorder>(
      //                     RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(29.0),
      //                     ),
      //                   ),
      //                 ),
      //                 child: Text(
      //                   "كـافـة الـتـفـاصـيـل",
      //                   style: TextStyle(fontFamily: 'myfont'),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Spacer(),
      //           Text(
      //             registered_child,
      //             style: TextStyle(fontSize: 18, fontFamily: 'myfont'),
      //           ),
      //           Spacer(),

      //            ClipOval(
      //              child: imageID.contains(data[index]['id'])?
      //              Image.network('http://192.168.1.19:3000/sanad/getImage?id=${imageID[imageID.indexOf(data[index]['id'])]}',
      //             width: 70,
      //             height: 60,
      //             fit: BoxFit.cover,)
      //             :Image.asset('images/profileImage.jpg', width: 70, height: 60,fit: BoxFit.cover,),
      //            ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }

  void _onPressed(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(name: name)),
    );
  }
}