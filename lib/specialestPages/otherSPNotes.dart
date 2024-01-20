// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sanad_software_project/auuth/signup.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;

class otherSpecialestNotes extends StatefulWidget{
  final String childID;
  final String spName;
  final String sesison;

  otherSpecialestNotes({super.key, required this.childID, required this.spName, required this.sesison});
  @override
  State<StatefulWidget> createState() {
    return otherSpecialestNotesState();
  }
}

class otherSpecialestNotesState extends State<otherSpecialestNotes>{

  late String childID;
  late String spName;
  late String sesison;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    childID=widget.childID;
    spName=widget.spName;
    sesison=widget.sesison;
  }


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: Container(
        color: primaryLightColor,
          width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: ListView(
            children: [
              SizedBox(height: 20,),
                Container(
                    color: primaryLightColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(spName,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                        SizedBox(width: 15,),
                        Text(": مـلاحــظــات",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                      ],),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    color: primaryLightColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(sesison,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                        SizedBox(width: 15,),
                        Text(": الــجــلــسـة",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                      ],),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context,index){
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              elevation: 2,
                              color: primaryLightColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("1/10/2023",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: secondaryColor)),
                                        SizedBox(width: 8,),
                                        Text(": الـتــاريـخ",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color:secondaryColor)),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Text("ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",textAlign: TextAlign.right,maxLines: null,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            );
                          })
            ],
          )
      ),
    );
  }

}