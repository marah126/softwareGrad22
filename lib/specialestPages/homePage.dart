// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sanad_software_project/specialestPages/sessionNotes.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;


class spHomePage extends StatefulWidget{
  final String id;
  final String name;
  spHomePage({required this.id, required this.name});
  @override
  State<StatefulWidget> createState() {
    return spHomePageState();
  }
}

class spHomePageState extends State<spHomePage>{

  late String id;
   String name="خديجة دريني";

  List<dynamic> data=[] ;
  List<DateTime> date=[];
  static List <bool> done=[];
  static int doneSessions=0;

  late DateTime d;
  DateTime now=DateTime.now();
  late int compare;

  @override
  void initState() {
    super.initState();
    setState(()  {
      id = widget.id;
      //name=widget.name;
      now =now.subtract(Duration(minutes: 30));
      getSPsessionsToday();
      print("nnnn"+now.toString());
    });
    print("home page id" + id);
  }

  Future<void> getSPsessionsToday()async{
    late final Map<String, dynamic>? data2;
    List<String> spname=name.split(" ");
    // final res = await http.get(
    // Uri.parse(ip + '/sanad/getspId?fname=${spname[0].trim()}&lastName=${spname[1].trim()}'),
    // );
    // data2=jsonDecode(res.body);
   // id=data2!['idd'];
    print("id"+id);

    final response = await http.get(
      Uri.parse(ip + '/sanad/getTODAYSessionsBySP?sp=$name'),
    );

    if (response.statusCode == 200) {
      print("okkk");
      print(response.body);
      data = jsonDecode(response.body);
      for(int i=0 ; i<data.length ; i++){
        setState(() {
          d=DateTime.parse(data[i]['date']).toLocal();
          print(d.toString());
        date.add(d);
        done.add(true);
        });
        
      }
      print("object");
    }
    else{
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
          width: size.width,
          height: size.height,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
            Text("الــجــدول الـــيــومــي",style: TextStyle(fontFamily: 'myFont',fontSize: 24,color: secondaryColor,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Card(
              color: primaryLightColor,
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(data.length.toString(),style: TextStyle(fontFamily: 'myFont',fontSize: 18,color: secondaryColor,fontWeight: FontWeight.bold)),
                    SizedBox(width: 20,),
                    Text(": عــدد الـجلـسـات الـكــلــيـة",style: TextStyle(fontFamily: 'myFont',fontSize: 20,color: secondaryColor,fontWeight: FontWeight.bold)),
                    SizedBox(width: 5,),
                    Icon(Icons.all_inclusive,color: secondaryColor,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              color: primaryLightColor,
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(doneSessions.toString(),style: TextStyle(fontFamily: 'myFont',fontSize: 18,color: secondaryColor,fontWeight: FontWeight.bold)),
                    SizedBox(width: 20,),
                    Text(": عــدد الـجلـسـات الـمـنـجـزة",style: TextStyle(fontFamily: 'myFont',fontSize: 20,color: secondaryColor,fontWeight: FontWeight.bold)),
                    SizedBox(width: 5,),
                    Icon(Icons.done,color: secondaryColor,)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Container(
                        width: size.width*0.7,
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:[
                                  Text(
                                    '${date[index].hour}:${date[index].minute}', // You can customize the subtitle based on the index
                                    style: TextStyle(
                                      fontFamily: 'myFont',
                                      fontSize: 20.0,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                Spacer(),
                                Text(
                                  data[index]['child'], // You can customize the title based on the index
                                  style: TextStyle(
                                    fontFamily: 'myFont',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                ]),
                                SizedBox(height: 5,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context, MaterialPageRoute(builder: (context){
                                        return sessionNotes(id: id,name: data[index]['child'],session: data[index]['session'],date: DateTime.parse(data[index]['date']).toLocal(),index: index,);}));},
                                  child: Text("تــوثــيــق",style: TextStyle(
                                    fontFamily: 'myFont',
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                  ),),
                                  )
                            ],
                          ),
                                
                        decoration: BoxDecoration(
                          color: Color(0xffE4CCFF), // Change this to your desired color
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      SizedBox(width: 10,), 
                      Icon( (now.hour< date[index].hour) || (now.hour == date[index].hour && now.minute < date[index].minute)  ? Icons.sync :
                        done[index]? Icons.done_all : Icons.highlight_off,
                        color: (now.hour< date[index].hour) || (now.hour == date[index].hour && now.minute < date[index].minute) ? const Color.fromARGB(255, 141, 195, 221) : done[index]? const Color.fromARGB(255, 144, 222, 147): const Color.fromARGB(255, 207, 142, 137),size: size.width*0.1),
                        
                    ]);
                  }
                  ),
              ),
              ),
          ]),
        ),
      ),
    );
  }
  void showDialogg(BuildContext context,int index){
    showDialog(
      context: context,
      builder:(context){
        Size size=MediaQuery.of(context).size;
      return AlertDialog(
        backgroundColor: primaryLightColor,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
        width: size.width*0.8,
        height: size.height*0.7,
        color: primaryLightColor,
        child: Column(
          children: [
            Text("تـوثـيـق الــجـلـسـة",style: TextStyle(fontFamily:'myFont',fontSize: 20,fontWeight: FontWeight.bold,color: secondaryColor),),
            SizedBox(height: 15,),
            Row(children: [
              Text(data[index]['child'],style: TextStyle(fontFamily:'myFont',fontSize: 16,fontWeight: FontWeight.bold,color: secondaryColor),),
              SizedBox(width: 10,),
              Text(': الــطـفـل',style: TextStyle(fontFamily:'myFont',fontSize: 16,fontWeight: FontWeight.bold,color: secondaryColor),),
            ],)
          ],
        ),
      ),
      );
      }
    );
  }
}
