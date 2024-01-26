// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sanad_software_project/theme.dart';

class evalobjec extends StatefulWidget {
  @override
  _evalobjecState createState() => _evalobjecState();
}

class _evalobjecState extends State<evalobjec> {
  bool isChecked = false;
  String itemm=myItems.first;
 static List<String> myItems = [
    'التركيز والانتباه ',
    'المهارات الإدراكية ',
    'التواصل البصري ',
    'المشاكل الصحية '
  ];
  List<Map<String, String>> obj1 = [
    {'percentage': '20%', 'object': 'ljbguyfdydcfgvhbjkldfcghbjkl;zxdcfgvhbjklasdfghb jnksdfghjnksdfghb jhjfu,dycyhj '},
    {'percentage': '50%', 'object': '--------------------------'},
    {'percentage': '40%', 'object': '-------------------------'},
  ];
  List<Map<String, String>> obj2 = [
    {'percentage': '50%', 'object': '======================'},
    {'percentage': '70%', 'object': '==============='},
    {'percentage': '90%', 'object': '=============='},
  ];
  List<Map<String, String>> obj3 = [
    {'percentage': '50%', 'object': '%%%%%%%%%%%'},
    {'percentage': '70%', 'object': '%%%%%%%%%%%%%%%%%%%%'},
    {'percentage': '90%', 'object': '%%%%%%%%%%%%%%%%%%'},
    {'percentage': '70%', 'object': '%%%%%%%%%%%%%%%%%%%%'},
    {'percentage': '90%', 'object': '%%%%%%%%%%%%%%%%%%%'},
  ];
  List<Map<String, String>> obj4 = [
    {'percentage': '50%', 'object': '************'},
    {'percentage': '70%', 'object': '***************************'},
    {'percentage': '90%', 'object': '********************************'},
  ];
  late List <Map<String, String>> list;
  List<Color>colors=[
    primaryLightColor,
    Color.fromARGB(255, 255, 255, 254),
    Color.fromARGB(255, 202, 211, 217),
    Color.fromARGB(255, 235, 241, 234)
  ];

  late List<bool> isCheckedList;
  late List<bool> isCheckedList2;
  late List<bool> isCheckedList3;
  late List<bool> isCheckedList4;

  @override
  void initState() {
    super.initState();
    list=obj1;
    isCheckedList = List.generate(obj1.length, (index) => false);
    isCheckedList2 = List.generate(obj2.length, (index) => false);
    isCheckedList3 = List.generate(obj3.length, (index) => false);
    isCheckedList4 = List.generate(obj4.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          " الأهـداف",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'myFont',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          color: Color(0xffFAF5FF),
          padding: EdgeInsets.symmetric(horizontal: 8),
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(height: 5),
                Text(
                  'العـلاج الـوظـيـفـي',
                  style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'myfont',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ghklse",style: TextStyle(fontFamily: 'myFont',fontSize: 20,color: secondaryColor),),
                    SizedBox(width: 10,),
                    Text(": الــطــفــل",style:TextStyle(fontFamily: 'myFont',fontSize: 20,color: secondaryColor))
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     DropdownButtonHideUnderline(
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
                              value: itemm,
                              onChanged: (value) {
                                setState(() {
                                  itemm = value!;
                                  list=obj2;
                                  //ss = value!;
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
                          SizedBox(width: 10,),
                          Text("اخـــتـــر الــمــهــارة ",style: TextStyle(fontFamily: 'myFont',fontSize: 20,color: secondaryColor),)
                  ],
                ),
                SizedBox(height: 20,),
               // for(int j=0;j<3;j++)
                Card(
                  margin: EdgeInsets.only(bottom: 20),
                  color: primaryLightColor,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          itemm,
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'myfont',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            for (int i = 0; i < list.length; i++)
                              Card(
                                margin: EdgeInsets.only(bottom: 20),
                                color: primaryLightColor,
                                elevation: 2,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          list[i]['percentage'] ?? '',
                                          style: TextStyle(
                                            fontFamily: 'myfont',
                                            color: Color(0xff161A30),
                                            fontSize: 20,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width:
                                              300, // Replace maxWidth with the maximum width you want to allow
                                          child: Text(
                                            list[i]['object'] ?? '',
                                            style: TextStyle(
                                              color: Color(0xff352F44),
                                              fontFamily: 'myfont',
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.right,
                                            maxLines:
                                                10, // Adjust the number of lines as needed
                                            overflow: TextOverflow
                                                .ellipsis, // Handle overflow by displaying ellipsis
                                          ),
                                        ),
                                        SizedBox(width: 5,)
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Spacer(),
                                        Checkbox(
                                          value: isCheckedList[i],
                                          onChanged: (value) {
                                            setState(() {
                                              isCheckedList[i] = value!;
                                            });
                                          },
                                          activeColor: primaryColor,
                                          checkColor: Colors.white,
                                        ),
                                        Spacer(),
                                        Text(
                                          'تـم تـحـقـيـق الـهـدف',
                                          style: TextStyle(
                                            color: Color(0xff352F44),
                                            fontFamily: 'myfont',
                                            fontSize: 15,
                                          ),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    // Divider(thickness: 0.8,color: Colors.grey,)
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Card(
                //   color: Color(0xffe6f6ff),
                //   child: Container(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: <Widget>[
                //         Text(
                //           '-:  الـمـهـارات الإدراكـيـة -',
                //           style: TextStyle(
                //               color: primaryColor,
                //               fontFamily: 'myfont',
                //               fontSize: 25,
                //               fontWeight: FontWeight.w200),
                //           textAlign: TextAlign.end,
                //         ),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           children: <Widget>[
                //             for (int i = 0; i < obj2.length; i++)
                //               Column(
                //                 children: <Widget>[
                //                   Row(
                //                     children: <Widget>[
                //                       Text(
                //                         obj2[i]['percentage'] ?? '',
                //                         style: TextStyle(
                //                           fontFamily: 'myfont',
                //                           color: Color(0xff161A30),
                //                           fontSize: 20,
                //                         ),
                //                       ),
                //                       Spacer(),
                //                       Text(
                //                         obj2[i]['object'] ?? '',
                //                         style: TextStyle(
                //                           color: Color(0xff352F44),
                //                           fontFamily: 'myfont',
                //                           fontSize: 20,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                   Row(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.center,
                //                     children: <Widget>[
                //                       Spacer(),
                //                       Checkbox(
                //                         value: isCheckedList2[i],
                //                         onChanged: (value) {
                //                           setState(() {
                //                             isCheckedList2[i] = value ?? false;
                //                           });
                //                         },
                //                         activeColor: primaryColor,
                //                         checkColor: Colors.white,
                //                       ),
                //                       Spacer(),
                //                       Text(
                //                         'تـم تـحـقـيـق الـهـدف',
                //                         style: TextStyle(
                //                           color: Color(0xff352F44),
                //                           fontFamily: 'myfont',
                //                           fontSize: 15,
                //                         ),
                //                       ),
                //                       Spacer(),
                //                     ],
                //                   )
                //                 ],
                //               ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                // Card(
                //   color: Color(0xfffff9e6),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: <Widget>[
                //       Text(
                //         '-: الـتـواصـل الـبـصـري -',
                //         style: TextStyle(
                //             color: primaryColor,
                //             fontFamily: 'myfont',
                //             fontSize: 25,
                //             fontWeight: FontWeight.w200),
                //         textAlign: TextAlign.end,
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: <Widget>[
                //           for (int i = 0; i < obj3.length; i++)
                //             Column(
                //               children: <Widget>[
                //                 Row(
                //                   children: <Widget>[
                //                     Text(
                //                       obj3[i]['percentage'] ?? '',
                //                       style: TextStyle(
                //                         fontFamily: 'myfont',
                //                         color: Color(0xff161A30),
                //                         fontSize: 20,
                //                       ),
                //                     ),
                //                     Spacer(),
                //                     Text(
                //                       obj3[i]['object'] ?? '',
                //                       style: TextStyle(
                //                         color: Color(0xff352F44),
                //                         fontFamily: 'myfont',
                //                         fontSize: 20,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 Row(
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: <Widget>[
                //                     Spacer(),
                //                     Checkbox(
                //                       value: isCheckedList3[i],
                //                       onChanged: (value) {
                //                         setState(() {
                //                           isCheckedList3[i] = value ?? false;
                //                         });
                //                       },
                //                       activeColor: primaryColor,
                //                       checkColor: Colors.white,
                //                     ),
                //                     Spacer(),
                //                     Text(
                //                       'تـم تـحـقـيـق الـهـدف',
                //                       style: TextStyle(
                //                         color: Color(0xff352F44),
                //                         fontFamily: 'myfont',
                //                         fontSize: 15,
                //                       ),
                //                     ),
                //                     Spacer(),
                //                   ],
                //                 )
                //               ],
                //             ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                // Card(
                //   color: Color(0xffebffe5),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: <Widget>[
                //       Text(
                //         '-: الـمـشـاكـل الـصـحـيـة -',
                //         style: TextStyle(
                //             color: primaryColor,
                //             fontFamily: 'myfont',
                //             fontSize: 25,
                //             fontWeight: FontWeight.w200),
                //         textAlign: TextAlign.end,
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: <Widget>[
                //           for (int i = 0; i < obj4.length; i++)
                //             Column(
                //               children: <Widget>[
                //                 Row(
                //                   children: <Widget>[
                //                     Text(
                //                       obj4[i]['percentage'] ?? '',
                //                       style: TextStyle(
                //                         fontFamily: 'myfont',
                //                         color: Color(0xff161A30),
                //                         fontSize: 20,
                //                       ),
                //                     ),
                //                     Spacer(),
                //                     Text(
                //                       obj4[i]['object'] ?? '',
                //                       style: TextStyle(
                //                         color: Color(0xff352F44),
                //                         fontFamily: 'myfont',
                //                         fontSize: 20,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 Row(
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: <Widget>[
                //                     Spacer(),
                //                     Checkbox(
                //                       value: isCheckedList4[i],
                //                       onChanged: (value) {
                //                         setState(() {
                //                           isCheckedList4[i] = value ?? false;
                //                         });
                //                       },
                //                       activeColor: primaryColor,
                //                       checkColor: Colors.white,
                //                     ),
                //                     Spacer(),
                //                     Text(
                //                       'تـم تـحـقـيـق الـهـدف',
                //                       style: TextStyle(
                //                         color: Color(0xff352F44),
                //                         fontFamily: 'myfont',
                //                         fontSize: 15,
                //                       ),
                //                     ),
                //                     Spacer(),
                //                   ],
                //                 )
                //               ],
                //             ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          )),
    );
  }
}
