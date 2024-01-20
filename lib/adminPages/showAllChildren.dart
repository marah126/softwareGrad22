// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sanad_software_project/adminPages/DetailsPageOfChildren.dart';
import 'package:sanad_software_project/theme.dart';

// class Registered_children {
//   final String name;
//   final String image;
//   final String details;

//   Registered_children(
//       {required this.name, required this.image, required this.details});
// }

class viewChildren extends StatefulWidget {
  @override
  _viewChidrenState createState() => _viewChidrenState();
}

class _viewChidrenState extends State<viewChildren> {

  String id="";
  List<String> children = [];
 // String img = 'assets/images/child1.png';
  late final List<dynamic> data ;
 // late final List<dynamic> image ;
  List<String> imagePath = [];
  List<String> imageID = [];
  //List<ImageDetails> imageDetailsList = [];


  Future<void> getChildrenImages()async{
    String path;
    String id;
    final images = await http.get(Uri.parse(ip+"/sanad/getAllImages"));
    if(images.statusCode==200){
      print(images.body);
    final List<dynamic> image = jsonDecode(images.body);
      for(int i=0;i<image.length;i++){
        path=image[i]['path'];
        id=image[i]['childID'];
        print(path);
        print(id);
        imagePath.add(path);
        imageID.add(id);
      }
      
    }
  }
  void zft(){
    print("==================================");
      for(int i=0; i<imagePath.length;i++){
        print("11"+data[i]['id']);
        print("22"+imageID[i]);
        print("33"+imageID.indexOf(imageID[i]).toString());
        print("44"+imagePath[i]);
        print("55"+imagePath[imageID.indexOf(data[i]['id'])]);
      }

      imageID.contains("112")? print("yes"):print("no");
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
      String childName;
      data = jsonDecode(childreNamesResponse.body);

      for (int i = 0; i < data.length; i++) {
        print(data[i]['Fname'] + " " + data[i]['Lname']);
        childName = data[i]['Fname'] + " " + data[i]['Lname'];
        setState(() {
          children.add(childName);
        });
      }
      for (int i = 0; i < children.length; i++) {
        print("ch" + children[i]);
      }
    } else if(childreNamesResponse.statusCode==404) {
      print("errrrrrrrror");
    }
  }


  @override
  void initState() {
    super.initState();

    getChildrenNames();
    getChildrenImages();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6f35a5),
         automaticallyImplyLeading: false,
        title: Text("الأطــــفـــال",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20),),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: ListView.builder(
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
                        print(imagePath[imageID.indexOf(data[index]['id'])]);
                        id=data[index]['id'];
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
                   child: imageID.contains(data[index]['id'])? 
                   Image.network('http://192.168.1.19:3000/sanad/getImage?id=${imageID[imageID.indexOf(data[index]['id'])]}',
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

  void _onPressed(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(name: name)),
    );
  }
 }
// class ImageDetails {
//   final String id;
//   final String path;

//   ImageDetails({required this.id, required this.path});
// / }