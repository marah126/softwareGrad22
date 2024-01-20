import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanad_software_project/adminPages/DetailsPageOfChildren.dart';
import 'package:sanad_software_project/adminPages/DetailsPageOfEmployee.dart';
import 'dart:convert';

import 'package:sanad_software_project/theme.dart';



// class Employee {
//   final String name;
//   final String image;
//   final String details;
//   Employee({required this.name, required this.image, required this.details});
// }



class viewSpecialest extends StatefulWidget {
  @override
  viewSpecialestState createState() => viewSpecialestState();
}

class viewSpecialestState extends State<viewSpecialest> {
  String id = "";

  List<String> EMP = [];
  String img = 'assets/images/person4.png';
  late final List<dynamic> data;
  List<String> imagePath = [];
  List<String> imageID = [];

  Future<void> getEmployeeName() async {
    // print("childrenssssssssssss");
    final EmployeeNamesResponse =
        await http.get(Uri.parse(ip + "/sanad/getspname"));
    if (EmployeeNamesResponse.statusCode == 200) {
      EMP.clear();
      String EmployeeName;
      data = jsonDecode(EmployeeNamesResponse.body);

      for (int i = 0; i < data.length; i++) {
        print(data[i]['Fname'] + " " + data[i]['Lname']);
        EmployeeName = data[i]['Fname'] + " " + data[i]['Lname'];
        setState(() {
          EMP.add(EmployeeName);
        });
      }
      for (int i = 0; i < EMP.length; i++) {
        print("ch" + EMP[i]);
      }
    } else {
      print("errrrrrrrror");
    }
  }

  Future<void> getSPImages()async{
    String path;
    String id;
    final images = await http.get(Uri.parse(ip+"/sanad/getAllSPImages"));
    if(images.statusCode==200){
      print(images.body);
    final List<dynamic> image = jsonDecode(images.body);
      for(int i=0;i<image.length;i++){
        path=image[i]['path'];
        id=image[i]['spID'];
        print(path);
        print(id);
        imagePath.add(path);
        imageID.add(id);
      }
      
    }
  }

  @override
  void initState() {
    super.initState();

    getEmployeeName();
    getSPImages();
  }

  void _onPressed(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => spDetailsPage(name: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6f35a5),
        automaticallyImplyLeading: false,
        title: Text("الأخــــصـــائـــيـــــيـــــن",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20),),
        centerTitle: true,
      ),
      
      body: ListView.builder(
        itemCount: EMP.length,
        itemBuilder: (context, index) {
          String employee = EMP[index];
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
                        id = data[index]['id'];
                        print(index);
                        print(id);
                        _onPressed(context, id);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF6F35A5)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(29.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "رؤيـة كـافـة الـتـفـاصـيـل",
                        style: TextStyle(fontFamily: 'myfont'),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  employee,
                  style: TextStyle(fontSize: 18, fontFamily: 'myfont'),
                ),
                Spacer(),
                ClipOval(
                   child: imageID.contains(data[index]['id'])? 
                   Image.network('http://192.168.1.19:3000/sanad/getSPImage?id=${imageID[imageID.indexOf(data[index]['id'])]}',
                  width: 70,
                  height: 60,
                  fit: BoxFit.cover,)
                  :Image.asset('assets/images/profileImage.jpg', width: 70, height: 60,fit: BoxFit.cover,),
                 ),
              ],
            ),
          );
        },
      ),
    );
  }
}