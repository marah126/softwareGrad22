// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sanad_software_project/specialestPages/childDetailesforSP.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;


class myChildren extends StatefulWidget{
  final String id;
  final String myname;
  const myChildren({super.key, required this.id, required this.myname});
  @override
  State<StatefulWidget> createState() {
    return myChildrenState();
  }
}

class myChildrenState extends State<myChildren>{
  late String id;
  String name ="سارة حنو";
  List<String>children=[];
  late final List<dynamic> data ;

  Future<void> getChildren()async{
    final childreNamesResponse =
          await http.get(Uri.parse(ip + "/sanad/getchnameSP?sp=$name"));
      if (childreNamesResponse.statusCode == 200) {
        children.clear();
        String childName;
        data = jsonDecode(childreNamesResponse.body);
        for (int i = 0; i < data.length; i++) {
        print(data[i]['firstName'] + " " + data[i]['lastName']);
        childName = data[i]['firstName'] + " " + data[i]['lastName'];
        setState(() {
          children.add(childName);
        });
      }
      }
      else{
        print("error");
      }
}
  @override
  void initState() {
    super.initState();
    id=widget.id;
    getChildren();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      
      body: 
         Container(
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          width: size.width,
          height: size.height,
          child: ListView.builder(
            itemCount: children.length,
            itemBuilder: (context,index){
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                     ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context){
                            return childDetailes(id: data[index]['idd'], name: children[index],myid: id,myname: widget.myname,);}));
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
                    Spacer(),
                    Text(
                      children[index],
                      style: TextStyle(fontSize: 18, fontFamily: 'myfont'),
                    ),
                    Spacer(),
                    Image.asset(
                      "assets/images/admin.png",
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              );
            }
          )
        ),
      
    );
  }

}