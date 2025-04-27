// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanad_software_project/auuth/signup.dart';
import 'package:sanad_software_project/specialestPages/objectives.dart';
import 'package:sanad_software_project/specialestPages/otherSPNotes.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;


class childDetailes extends StatefulWidget{
  final String id;
  final String name;
  final String myid;
  final String myname;

  const childDetailes({super.key, required this.id, required this.name, required this.myid, required this.myname});
  @override
  State<StatefulWidget> createState() {
    return childDetailesState();
  }

}

class childDetailesState extends State<childDetailes>{
  late String id;
  late String name;
  final List<Map<String, String>> rowData = [
    {'column1': 'ليلى دويكات', 'column2': '1', 'column3': 'اللغة والنطق'},
    
  ];
  List<dynamic>notes=[];
  List<dynamic>sessions=[];

  Future<void> getMyNotes()async{
    final myNotes=await http.get(Uri.parse('$ip/sanad/getmyNotes?spid=${widget.myid}&cid=$id'));
    if(myNotes.statusCode==200){
      setState(() {
        notes=jsonDecode(myNotes.body);
      });
      print(notes);
    }
  }

  Future<void> getChildInfo() async {
    Map<String,dynamic> ?data ;
    final response = await http.get(
    Uri.parse(ip + '/sanad/getChildInfoByID?id=$id'),
    );

    if (response.statusCode == 200) {
      print("okkk");
      //print(response.body);
      data = jsonDecode(response.body);
      setState(() {
        sessions = data!['sessions'];

      });
      
    } else {
      print(response.reasonPhrase);
      print("error");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id=widget.id;
    name=widget.name;
    print("====== $id");
    print("==========$name");
    print(widget.myid);
    getMyNotes();
    getChildInfo();
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
            children: [Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  width: 250,
                  child: ClipOval(
                    child: Image.asset("assets/images/R.jpg",width: 250,height: 250,fit: BoxFit.cover,)),
                ),
                SizedBox(height: 20,),
                Card(
                    color: primaryLightColor,
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                        SizedBox(width: 15,),
                        Text(": الــطــفــل",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                      ],),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Card(
                    color: primaryLightColor,
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Text("8",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                        SizedBox(width: 15,),
                        Text(": الــعــمــر",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                      ],),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Card(
                    color: primaryLightColor,
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Text("متلازمة داون",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                        SizedBox(width: 15,),
                        Text(": الــتـشـخـيـص",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                      ],),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: size.width,
                    child: Card(
                      color: primaryLightColor,
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          Text(
                            " الــجـلـســات",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'myFont',
                                fontSize: 20,
                                color: Colors.black87),
                          ),
                          SizedBox(height: 5,),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('الأخـصـائـيـة',style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 18,color: secondaryColor)),
                              Spacer(),
                              Text('الــعـدد',style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 18,color: secondaryColor)),
                              Spacer(),
                              Text('الـجـلـسـة',style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 18,color: secondaryColor),),
                            ],
                          ),
                          SizedBox(height:1),
                          Container(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: sessions.length,
                              itemBuilder: (context,index){
                              return TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: primaryColor,
                                  backgroundColor: primaryLightColor
                                ),
                                onPressed: () {
                                  print(index);
                                  Navigator.push(context,MaterialPageRoute(builder: (context){return otherSpecialestNotes(childID: sessions[index]['sessionName']!,sesison: sessions[index]['sessionName']!,spName: sessions[index]['specialest']!,);}));
                                  
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 15),
                                        child:
                                        sessions[index]['specialest']==widget.myname?Row() :
                                       Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(sessions[index]['specialest']!,style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black87)),
                                        Spacer(),
                                        Text(sessions[index]['no']!.toString(),style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black87)),
                                        Spacer(),
                                        Text(sessions[index]['sessionName']!,style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black87))
                                      ],
                                                                     ),
                          
                                ),
                              );
                              }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: size.width,
                  color: primaryLightColor,
                  child: Card(
                    color: primaryLightColor,
                    elevation: 2,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                        child: Column(
                          children: [
                            Text(
                            " مـلاحــظــات جـلـسـاتـي",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'myFont',
                                fontSize: 20,
                                color: Colors.black87),
                          ),
                          SizedBox(height: 7,),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            shrinkWrap: true,
                            itemCount: notes.length,
                            itemBuilder: (context,index){
                              DateTime d=DateTime.parse(notes[index]['date']).toLocal();
                              print(d);
                              // String format=DateFormat()
                              return Column(
                                children: [
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(DateFormat("dd/MM/yyyy").format(d),style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: secondaryColor)),
                                    SizedBox(width: 8,),
                                    Text(": الـتــاريـخ",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color:secondaryColor)),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Text(notes[index]['personalNotes'],textAlign: TextAlign.right,maxLines: null,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                                SizedBox(height: 10,),
                                Divider(thickness: 2,),
                                SizedBox(height: 10,),
                                ],
                              );
                            // return Column(
                            //   children: [
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         Text("31/12/2023",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: secondaryColor)),
                            //         SizedBox(width: 8,),
                            //         Text(": الـتــاريـخ",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color:secondaryColor)),
                            //       ],
                            //     ),
                            //     SizedBox(height: 20,),
                            //     Text("لاحظت تشتت تركيز الطفل بهذه الجلسة ومواجهة صعوبة في التعامل معه نظراً لمزاجه المتعكر",textAlign: TextAlign.right,maxLines: null,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                            //     SizedBox(height: 10,),
                            //     Divider(thickness: 2,),
                            //     SizedBox(height: 10,),
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         Text("5/1/2024",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: secondaryColor)),
                            //         SizedBox(width: 8,),
                            //         Text(": الـتــاريـخ",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color:secondaryColor)),
                            //       ],
                            //     ),
                            //     SizedBox(height: 20,),
                            //     Text("استجابة الطفل هذه الجلسة افضل من السابقة لكن لازال يجب العمل على موضوع التركيز",textAlign: TextAlign.right,maxLines: null,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                            //     SizedBox(height: 10,),
                            //     Divider(thickness: 2,),
                            //     SizedBox(height: 10,),
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         Text("12/1/2024",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: secondaryColor)),
                            //         SizedBox(width: 8,),
                            //         Text(": الـتــاريـخ",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color:secondaryColor)),
                            //       ],
                            //     ),
                            //     SizedBox(height: 20,),
                            //     Text("تحسن ملحوظ في الاستجابة للتعليمات",textAlign: TextAlign.right,maxLines: null,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                            //     SizedBox(height: 10,),
                            //     Divider(thickness: 2,),
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         Text("29/1/2024",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: secondaryColor)),
                            //         SizedBox(width: 8,),
                            //         Text(": الـتــاريـخ",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color:secondaryColor)),
                            //       ],
                            //     ),
                            //     SizedBox(height: 20,),
                            //     Text("تفاعل ممتاز وتركيز عالي اثناء الجلسة ",textAlign: TextAlign.right,maxLines: null,style: TextStyle(fontFamily: 'myFont',fontSize: 18),),
                            //     SizedBox(height: 10,),
                            //     Divider(thickness: 2,),

                            //   ],
                            // );
                          }),
                          ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () async {
                          print("inside func");
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return goals(childId: widget.id, spId: widget.myid);
                          },));
                          
                        },
                        child: Text(
                          "الأهــداف",
                          style: TextStyle(
                              fontFamily: 'myFont',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        )),
                          ],
                        )
                    )
                  ),
                )
          
              ],
            ),
          ]),
        ),
      
    );
  }

}


// //DataTable(
//                           columns: [
//                             DataColumn(label: Text('الـجـلـسـة',style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: secondaryColor),)),
//                             DataColumn(label: Text('الــعـدد',style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: secondaryColor))),
//                             DataColumn(label: Text('الأخـصـائـيـة',style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 17,color: secondaryColor))),
//                             // Add more DataColumn widgets for additional columns
//                           ],
//                           rows: List.generate(rowData.length, (index) {
//                             final row = rowData[index];
//                             return DataRow(
//                               onSelectChanged: (selected) {
//                                 // Your action when the row is tapped
//                                 if (selected != null && selected) {
//                                   print(
//                                       'index $index Row tapped: ${row['column1']}, ${row['column2']}, ${row['column3']}');
//                                 }
//                               },
//                               cells: [
//                                 DataCell(Text(rowData[index]['column1']!)),
//                                 DataCell(Text(rowData[index]['column2']!)),
//                                 DataCell(Text(rowData[index]['column3']!)),
//                                 // Add more DataCell widgets for additional columns
//                               ],
//                             );
//                           })
//                         ),