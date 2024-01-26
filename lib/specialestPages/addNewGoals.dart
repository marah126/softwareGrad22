// ignore_for_file: prefer_const_constructors


import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sanad_software_project/components/roundedTextFeild2.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/theme.dart';

class newGoals extends StatefulWidget {
  final String childId;
  final String spId;

  const newGoals({super.key, required this.childId, required this.spId});
  @override
  _newGoalsState createState() => _newGoalsState();
}

class _newGoalsState extends State<newGoals> {
  String childId="123456789";
  String spId="987654321";
  List<String> selectedValues = [];
  List<String> myItems = [
    'التركيز والانتباه ',
    'المهارات الإدراكية ',
    'التواصل البصري ',
    'المشاكل الصحية '
  ];

  List<Widget> goalCards = [];
  List<TextEditingController> controllerList = [];
  List<TextEditingController> percentcontrollerList = [];
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();



 int index=0;

void func() {
  if(goalCards.isEmpty){
    print("hi");
    print(c1.text);
    print(c2.text);
  }else{
    print("hhhhhhhhhhhhhhhhiiiiiiiiiiiiiiiiii");
    for(int i=0; i<goalCards.length;i++){
      print(controllerList[i].text);
      print(percentcontrollerList[i].text);
    }
  }
}


  Future<void> postnewGoals() async{
    try{
      for(int i=0; i<goalCards.length ; i++){
        
      }
    }catch(error){
      print("error $error");
    }
  }  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TextEditingController newController = TextEditingController();
    TextEditingController percentController = TextEditingController();
    String selected=myItems.first;
    selectedValues.add(selected);
    controllerList.add(newController);
    percentcontrollerList.add(percentController);
    goalCards.add(Card(
          key: ValueKey<String>('card_$index'),
          color: primaryLightColor,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedValues[index],
                          items: myItems.map(( value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontFamily: 'myFont',
                                  color: Color(0xff161A30),
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: ( value2) {
                            setState(() {
                              selectedValues[index]=value2!;
                            });
                          },
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'إضـافـة هـدف إلـى',
                      style: TextStyle(
                        fontFamily: 'myFont',
                        color: Color(0xff161A30),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 5,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    RoundedTextField2(
                      width: 120,
                      child: TextField(
                        controller: percentcontrollerList[index],
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'الـنـسـبـة',
                          hintStyle: TextStyle(fontFamily: 'myFont'),
                          suffixText: '%',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Spacer(),
                    RoundedTextField2(
                      width: 250,
                      child: TextField(
                        textAlign: TextAlign.right,
                         controller: controllerList[index],
                        decoration: InputDecoration(
                          hintText: 'الـهـدف',
                          hintStyle: TextStyle(fontFamily: 'myFont'),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: 5,)
              ],
            ),
          ),
        ),);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          " إضـافـة أهـداف جـديـدة",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'myFont',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 5),
              Text(
                'العـلاج الـوظـيـفـي',
                style: TextStyle(
                    color: primaryColor,
                    fontFamily: 'myfont',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  ...goalCards,
                  // if (goalCards.isEmpty)
                  //   Card(
                  //     elevation: 5,
                  //     color: primaryLightColor,
                  //     child: Container(
                  //       padding: EdgeInsets.symmetric(horizontal: 8),
                  //       child: Column(
                  //         children: <Widget>[
                  //           Row(
                  //             children: <Widget>[
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  //                 child: DropdownButtonHideUnderline(
                  //                   child: DropdownButton<String>(
                  //                     value: selectedValues.last,
                  //                     items: myItems.map((String value) {
                  //                       return DropdownMenuItem<String>(
                  //                         value: value,
                  //                         child: Text(
                  //                           value,
                  //                           style: TextStyle(
                  //                             fontFamily: 'myfont',
                  //                             color: Color(0xff161A30),
                  //                             fontSize: 20,
                  //                           ),
                  //                         ),
                  //                       );
                  //                     }).toList(),
                  //                     onChanged: (String? value) {
                  //                       setState(() {
                  //                         selectedValues[
                  //                             selectedValues.length - 1] = value!;
                  //                       });
                  //                     },
                  //                   ),
                  //                 ),
                  //               ),
                  //               Spacer(),
                  //               Text(
                  //                 'إضـافـة هـدف إلـى',
                  //                 style: TextStyle(
                  //                   fontFamily: 'myfont',
                  //                   color: Color(0xff161A30),
                  //                   fontSize: 20,
                  //                 ),
                  //               ),
                  //               SizedBox(width: 5,)
                  //             ],
                  //           ),
                  //           Row(
                  //             children: <Widget>[
                  //               RoundedTextField2(
                  //                 width: 120,
                  //                 child: TextField(
                  //                   controller: c1,
                  //                   textAlign: TextAlign.right,
                  //                   decoration: InputDecoration(
                  //                     hintText: 'الـنـسـبـة',
                  //                     hintStyle: TextStyle(fontFamily: 'myFont'),
                  //                     suffixText: '%',
                  //                     border: InputBorder.none,
                  //                   ),
                  //                 ),
                  //               ),
                  //               Spacer(),
                  //               RoundedTextField2(
                  //                 width: 250,
                  //                 child: TextField(
                  //                   textAlign: TextAlign.right,
                  //                    controller: c2,
                  //                   decoration: InputDecoration(
                  //                     hintText: 'الـهـدف',
                  //                     hintStyle: TextStyle(fontFamily: 'myFont'),
                  //                     border: InputBorder.none,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           // Container(
                  //           //   width: 200,
                  //           //   padding: EdgeInsets.only(bottom: 5),
                  //           //   child: RoundedButton(
                  //           //     color: primaryColor,
                  //           //     text: "إضـافـة ",
                  //           //     textColor: Colors.white,
                  //           //     press: () {
                  //           //       showDialog(
                  //           //         context: context,
                  //           //         builder: (BuildContext context) {
                  //           //           return AlertDialog(
                  //           //             content: Text(
                  //           //               'تـمـت  ',
                  //           //               style: TextStyle(
                  //           //                 fontFamily: 'myFont',
                  //           //                 color: primaryColor,
                  //           //                 fontSize: 20,
                  //           //               ),
                  //           //               textAlign: TextAlign.center,
                  //           //             ),
                  //           //           );
                  //           //         },
                  //           //       );
                  //           //     },
                  //           //   ),
                  //           // ),
                  //           SizedBox(height: 5,),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                ],
              ),

              SizedBox(height: 30),
              // SizedBox(height: 20),
              Container(
                child: RoundedButton(
                  color: primaryColor,
                  text: "إضـافـة هـدف جـديـد",
                  textColor: Colors.white,
                  press: () {
                    addNewGoalCard();
                  },
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: RoundedButton(
                  color: primaryColor,
                  text: "savve",
                  textColor: Colors.white,
                  press: () {
                    func();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addNewGoalCard() {
    index++;
    print(index);
    TextEditingController newController = TextEditingController();
    TextEditingController percentController = TextEditingController();
    String selected=myItems.first;
    selectedValues.add(selected);
    controllerList.add(newController);
    percentcontrollerList.add(percentController);
    setState(() {
      goalCards.add(
        Card(
          key: ValueKey<String>('card_$index'),
          color: primaryLightColor,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: myItems
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              fontSize: 14, fontFamily: 'myFont'),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValues[index],
                              onChanged: (value) {
                                print(value);
                                print("index $index");
                                setState(() {
                                  selectedValues[index]=value!;
                                  print(selectedValues[index]);
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: 160,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border:
                                        Border.all(color: primaryColor, width: 2),
                                    color: Colors.white),
                                elevation: 2,
                              ),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 200,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                    ),
                    Spacer(),
                    Text(
                      'إضـافـة هـدف إلـى',
                      style: TextStyle(
                        fontFamily: 'myFont',
                        color: Color(0xff161A30),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 5,)
                  ],
                ),
                Row(
                  children: <Widget>[
                    RoundedTextField2(
                      width: 120,
                      child: TextField(
                        controller: percentcontrollerList[index],
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'الـنـسـبـة',
                          hintStyle: TextStyle(fontFamily: 'myFont'),
                          suffixText: '%',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Spacer(),
                    RoundedTextField2(
                      width: 250,
                      child: TextField(
                        textAlign: TextAlign.right,
                         controller: controllerList[index],
                        decoration: InputDecoration(
                          hintText: 'الـهـدف',
                          hintStyle: TextStyle(fontFamily: 'myFont'),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                // Container(
                //   width: 200,
                //   padding: EdgeInsets.only(bottom: 5),
                //   child: RoundedButton(
                //     color: primaryColor,
                //     text: "إضـافـة ",
                //     textColor: Colors.white,
                //     press: () {
                //       int indexx=index;
                //       print(widget.key);
                //       print(indexx);
                //       // for(int i=0;i<goalCards.length;i++){
                //       //   print(goalCards[i].key);
                //       //   print(Key('card_$indexx'));
                //       //   if(Key('card_$indexx')==goalCards[i].key){
                //       //     print('Clicked on button in card at index $indexx $i');
                //       //   }
                //         // int cardIndex = goalCards.indexWhere((widget) => widget.key == Key('card_$indexx'));
                //       // }
                      
                //       // print(controllerList[index].text);
                //       showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return AlertDialog(
                //             content: Text(
                //               'تـمـت إضـافـة الـهـدف',
                //               style: TextStyle(
                //                 fontFamily: 'myfont',
                //                 color: primaryColor,
                //                 fontSize: 20,
                //               ),
                //               textAlign: TextAlign.center,
                //             ),
                //           );
                //         },
                //       );
                //     },
                //   ),
                // ),
                SizedBox(height: 5,)
              ],
            ),
          ),
        ),
      );
    });
  }
}

class cards{
  final int index;
  final Widget widget;

  cards({required this.index, required this.widget});

}