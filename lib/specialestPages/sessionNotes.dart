// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/specialestPages/homePage.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;


class sessionNotes extends StatefulWidget{
  final String id;
  final String name;
  final String session;
  final DateTime date;
  final int index;
  sessionNotes({required this.id, required this.name, required this.session, required this.date, required this.index});
  @override
  State<StatefulWidget> createState() {
    return sessionNotesState();
  }
}

class sessionNotesState extends State<sessionNotes>{
  late String id;
  late String name;
  late String session;
  late DateTime date;
  late int index;
  late String childID;
  String selectedOption = '';
  DateTime now=DateTime.now();
  late bool attendence;

  final TextEditingController personalNotes = TextEditingController();
  final TextEditingController spNotes = TextEditingController();
  final TextEditingController parentNotes = TextEditingController();

  Future<void>getID()async{
    final Map<String,dynamic> ?data ;
    List<String> childname=name.split(" ");
    final response = await http.get(
    Uri.parse(ip + '/sanad/getchildId?fname=${childname[0].trim()}&lastName=${childname[1].trim()}'),
    );
    if(response.statusCode==200){
      print(childname);
      data=jsonDecode(response.body);
      childID=data!['idd'];
      print(childID);

    }
    else{
      print("error");
    }
  }


  Future<void>addNewNote(BuildContext context)async{
    print("insssiiideeeeeeeeeeeeeeeeeee");
    if(attendence==true){
      final response = await http
          .post(Uri.parse(ip+"/sanad/addNotes"), body: {
            'idd':childID,
            'specialest':name,
            'session':session,
            'date':date.toUtc().toIso8601String(),
            'personalNotes':personalNotes.text,
            'spNotes':spNotes.text,
            'parentsNotes':parentNotes.text      
      });
    }else{
      showAlert(context);
      print("nnnnnnnnnnnnnooooooooooooooooooooonoonon");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id=widget.id;
    name=widget.name;
    session=widget.session;
    date=widget.date;
    index=widget.index;
    getID();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false, // Disable the default back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => spHomePage(id: id,name: name,),
            ),
            );

          },
        )
      ),
      body: 
         Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("تــوثـيــق الـجلـســة",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 22,color: secondaryColor),),
                SizedBox(height: 20,),
                Card(
                  color: Colors.white,
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
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      Text(session,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                      SizedBox(width: 15,),
                      Text(": الــجــلـســة",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                    ],),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      Text(DateFormat("yyyy/MM/dd").format(now),style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87)),
                      //Text(DateFormat('hh : mm').format(date),style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                      SizedBox(width: 15,),
                      Text(": الــتـاريــخ",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                    ],),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      //Text(DateFormat("yyyy/MM/dd  ").format(now),style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87)),
                      Text(DateFormat('hh : mm').format(date),style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                      SizedBox(width: 15,),
                      Text(": الــوقــت",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                    ],),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('لا',style: TextStyle(fontFamily: 'myFont',fontSize: 18,color: Colors.black87,fontWeight: FontWeight.bold)),
                        Radio(
                          activeColor: primaryColor,
                          value: 'No',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                              attendence=false;
                            });
                          },
                        ),
                         Text('نــعــم',style: TextStyle(fontFamily: 'myFont',fontSize: 18,color: Colors.black87,fontWeight: FontWeight.bold)),
                        Radio(
                          activeColor: primaryColor,
                          value: 'Yes',
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value.toString();
                              attendence=true;
                            });
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "هــل حـضـر الــطـفـل الـجـلـسـة؟",
                          style: TextStyle(
                              fontFamily: 'myFont',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                    child: Column(children: [
                      Text("مــلاحــظــات ",style: TextStyle(fontFamily: 'myFont',fontSize: 18,color: secondaryColor,fontWeight: FontWeight.bold)),
                      Container(
                        width: size.width,
                        height:150,
                        child: TextField(
                          controller: personalNotes,
                          maxLines: null,
                          maxLength: null,
                          cursorColor: primaryColor,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "... اكـتـب",
                            hintStyle: TextStyle(fontFamily: 'muFont'),
                            border: InputBorder.none,
                            
                          ),
                        ),
                      )
                    ]),
                  ),  
                ),
                SizedBox(height: 10,),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                    child: Column(children: [
                      Text("مــلاحــظــات لـلأخــصـائـيـيـن ",style: TextStyle(fontFamily: 'myFont',fontSize: 18,color: secondaryColor,fontWeight: FontWeight.bold)),
                      Container(
                        width: size.width,
                        height:150,
                        child: TextField(
                          controller: spNotes,
                          maxLines: null,
                          maxLength: null,
                          cursorColor: primaryColor,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "... اكـتـب",
                            hintStyle: TextStyle(fontFamily: 'muFont'),
                            border: InputBorder.none,  
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                    child: Column(children: [
                      Text("مــلاحــظــات لأهــل الــطـفـل ",style: TextStyle(fontFamily: 'myFont',fontSize: 18,color: secondaryColor,fontWeight: FontWeight.bold)),
                      Container(
                        width: size.width,
                        height:150,
                        child: TextField(
                          controller: parentNotes,
                          maxLines: null,
                          maxLength: null,
                          cursorColor: primaryColor,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "... اكـتـب",
                            hintStyle: TextStyle(fontFamily: 'muFont'),
                            border: InputBorder.none,    
                          ),
                        ),
                      )
                    ]),
                  ),   
                ),
                SizedBox(height: 10,),
                RoundedButton(
                  press: ()=>{
                    addNewNote(context)
                  },
                  //() {
                  //   if(selectedOption=='No'){
                  //     setState(() {
                  //       spHomePageState.done[index]=false;
                  //     });
                  //   }
                  //   else{
                  //     setState(() {
                  //       spHomePageState.doneSessions++;
                  //       spHomePageState.done[index]=true;
                  //     });
                  //   }
                  //   addNewNote();
                  // },
                  text: "حــفــظ",
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),
        ),
    );
  }

  void showAlert(BuildContext context){
    showDialog(
    context: context,
    builder: (BuildContext context) {
      Size size=MediaQuery.of(context).size;
      return AlertDialog(
        backgroundColor: primaryLightColor,
        content: Container(
          alignment: Alignment.center,
          width:size.width*0.6 ,
          height: 170,
          child: Column(
            children:[
              Icon(
                Icons.error, // You can change this to any other icon
                size: 50,
                color: secondaryColor,
              ),
              SizedBox(height: 10),
               Text("لا يـمـكـن إضـافــة مــلاحـظـات لـطـفـل غـائــب",
                style: TextStyle(fontFamily: 'myFont',fontSize: 20,color: secondaryColor),
                textAlign: TextAlign.center,),
            ]
              ),
            
        ),
        
        
        
        
      );
    },
  );
  }

}