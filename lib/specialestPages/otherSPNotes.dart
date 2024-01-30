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

  List<String> notes=[
    'يعاني الطفل من تشتت في التركيز يجب العمل عليه في جميع الجلسات',
    'هناك تطور طفيف في تركيز الطفل',
    'اقوم حاليا بتطوير قدرة الطفل في التعبير عن ما يريد لفظيا ، ارجوكم ان تجعلو الطفل يعبر باللفظ لا بالإشارة خلال جلساتكم',
    'لاحظت تطور جيد في تركيز الطفل اثناء الجلسة واستجابته للمعطيات',
    'لقد بدأت العمل على النطق السليم للكلمات ومخارج الحروف الصحيحة ارجو اعطائي ملاحظاتكم'
  ];

  List <String>dd=[
    '28/12/2023',
    '4/1/2024',
    '8/1/2024',
    '11/1/2024',
    '18/1/2024'
  ];

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
        color: Color(0xffF9F5FF),
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
                                        Text(dd[index],style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: secondaryColor)),
                                        SizedBox(width: 8,),
                                        Text(": الـتــاريـخ",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color:secondaryColor)),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    Text(notes[index],textAlign: TextAlign.right,maxLines: null,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
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