// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanad_software_project/adminPages/addNewChild.dart';
import 'package:sanad_software_project/adminPages/addNewSpecialest.dart';
import 'package:sanad_software_project/adminPages/c.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/adminPages/showAllChildren.dart';
import 'package:sanad_software_project/notification.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

class adminHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return adminHomeState();
  }
}

class adminHomeState extends State<adminHome>{
    final TextEditingController textEditingController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        // height: double.infinity,
         child:
        // Stack(children: [
        //   Positioned(
        //       bottom: 0,
        //       right: 0,
        //       child: Image.asset("assets/images/welcome_bottom_right.png")),
          
              Container(
                child: SfCalendar(
                  dataSource: _getCalendarAppointments(),
                  view: CalendarView.schedule,
                  todayHighlightColor: primaryColor,
                  scheduleViewSettings: ScheduleViewSettings(
                    appointmentItemHeight: 100,
                    hideEmptyScheduleWeek: true,
                    appointmentTextStyle: TextStyle(color: Colors.black,fontFamily: 'myFont',fontSize: 16),
                    weekHeaderSettings: WeekHeaderSettings(
                      startDateFormat: " ",
                      endDateFormat: " ",
                    ),
                    dayHeaderSettings: DayHeaderSettings(
                      dayTextStyle: TextStyle(color: primaryColor,fontSize: 19)
                    ),
                    monthHeaderSettings: MonthHeaderSettings(
                      monthTextStyle: TextStyle(color: primaryLightColor,fontWeight: FontWeight.bold),
                      backgroundColor: secondaryColor
                    )
                  ),
                  onTap: (CalendarTapDetails details) {
                    if (details.targetElement == CalendarElement.appointment) {
                      showEventInputDialog(details,false);
                      // showEventInputDialog(details,false);
                    } 
                  },
              ),)
            ,)
        
      
    );
  }

  Map<String, Color> colorMap = {
    'الـلغـة و نــطــق': primaryLightColor,
    'ســلــوكــي': Color(0xffb1a1b3),
    'وظــيــفــي': Color(0xfffff9e6),
    'تــربـيـة خـاصـة': Color(0xffe6f6ff),
    'عــلاج طــبـيـعي': Color(0xffEBFFE5)
  };
  static  List<String> children = [
     ' ',
    // 'Item 2',
    // 'Item 3',
    // 'Item 4',
    // 'Item 5',
    // 'Item 11',
    // 'Item 21',
    // 'Item 31',
    // 'Item 41',
    // 'Item 51',
    // 'Item 12',
    // 'Item 22',
    // 'Item 32',
    // 'Item 42',
    // 'Item 52',
  ];
  static  List<String> specialests = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 11',
    'Item 21',
    'Item 31',
    'Item 41',
    'Item 51',
    'Item 12',
    'Item 22',
    'Item 32',
    'Item 42',
    'Item 52',
  ];
  List<CustomEvent> events = [];
  static const List<String> sessions = [
    'سلوكي',
    'وظيفي',
    'تربية خاصة',
    'علاج طبيعي',
    'اللغة و النطق ',
  ];
  String selectedValue = children.first;
  String selectedValue2 = specialests.first;
  String selectedValue3 = sessions.first;
  String selectedDateweek = "";
  String day="";

  List<DateTime> visibleDates = [];
  List<String> visibleDatesString = [];
  late CustomEvent newSession;

  int autoID=0;
   CalendarDataSource _getCalendarAppointments() {
    DateTime d = DateTime.now();
    DateTime firstDayOfNextMonth = DateTime(d.year, d.month + 1, 1);
    DateTime lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
   // d = d.add(const Duration(days: 10));
    final List<Appointment> appointments = <Appointment>[];

    for (final CustomEvent event in events) {
      appointments.add(Appointment(
          id: event.id,
          startTime: event.from,
          endTime: event.to,
          subject: event.child+"  --  "+event.specialest+"  --  "+event.session,
          color: event.color,
          recurrenceRule: 'FREQ=DAILY;INTERVAL=7;UNTIL=$lastDayOfCurrentMonth'));
    }
    return _DataSource(appointments);
  }

  Future<void> getChildrenNames() async{
    int x=0;
    if (x == 0) {
     // print("childrenssssssssssss");
      final childreNamesResponse =
          await http.get(Uri.parse(ip + "/sanad/getchname"));
      if (childreNamesResponse.statusCode == 200) {
        children.clear();
        String childName;
        final List<dynamic> data = jsonDecode(childreNamesResponse.body);

        for (int i = 0; i < data.length; i++) {
          //print(data[i]['Fname'] + " " + data[i]['Lname']);
          childName = data[i]['Fname'] + " " + data[i]['Lname'];
          setState(() {
            children.add(childName);
          });
        }
        for(int i=0;i<children.length;i++){
          print("ch"+children[i]);
        }
      } else {
        print("errrrrrrrror");
      }
      x++;
    }
      if (x == 1) {
      final specialestNamesResponse =
          await http.get(Uri.parse(ip + "/sanad/getspname"));
      if (specialestNamesResponse.statusCode == 200) {
        specialests.clear();
        String spName;
        final List<dynamic> data2 = jsonDecode(specialestNamesResponse.body);

        for (int i = 0; i < data2.length; i++) {
          print(data2[i]['Fname'] + " " + data2[i]['Lname']);
          spName = data2[i]['Fname'] + " " + data2[i]['Lname'];
          setState(() {
            specialests.add(spName);
          });
        }
        for(int i=0;i<specialests.length;i++){
          print("sp"+specialests[i]);
        }
      } else {
        print("errrrrrrrror");
      }
    }
  }
  

  Future<void> getAllSessions()async{

    CustomEvent e;
    DateTime dd;
    String s;
    final allSessions=await http.get(Uri.parse(ip+"/sanad/getTodaySessions"));
    if (allSessions.statusCode == 200) {
        String childName;
        final List<dynamic> data = jsonDecode(allSessions.body);
        autoID=data.length;
        print("autoid= "+autoID.toString());
        for(int i=0;i<data.length;i++){
          print(data[i]);
          dd=DateTime.parse(data[i]['date']).toLocal();
          s=data[i]['session'];
          e=CustomEvent(data[i]['idd'], data[i]['child'], data[i]['specialest'], data[i]['session'], dd, dd.add(Duration(minutes: 40)), colorMap[s.toLowerCase()]!);
          events.add(e);
        }
    }
  }

  Future<void> _loadData() async {
  await getChildrenNames();
  await getAllSessions();
  // Additional code that should execute after both functions are complete
}

  @override
    void initState() {
      super.initState();
      
      // Call your function here
       getChildrenNames();
       getAllSessions();
      pushNotificationsManager.requestPermission();
      //_loadData();
    }



    void showEventInputDialog(CalendarTapDetails selectedDate, bool flag) {
    int id;
    selectedValue=children.first;
    selectedValue2=specialests.first;
    print("xxxxxxxx"+selectedValue);
    Color color;
    Size size = MediaQuery.of(context).size;
    String ch = "";
    String sp = "";
    String ss = "";
    if(flag==false){
      ch=children.first;
      sp=specialests.first;
      ss=sessions.first;
    }else{
      id = selectedDate.appointments![0].id;
      //events.firstWhere((element) => element.id == id);
      ch=events.firstWhere((element) => element.id == id).child;
      sp=events.firstWhere((element) => element.id == id).specialest;
      ss=events.firstWhere((element) => element.id == id).session;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'إضــافــة مــوعــد جــديــد',
              style: TextStyle(
                fontFamily: 'myFont',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
              textAlign: TextAlign.right,
            ),
            content: Container(
              color: Colors.white,
              width: size.width * 0.5,
              height: size.height * 0.5,
              child: SingleChildScrollView(
                child: StatefulBuilder(builder: (context, setState) {
                  // Use StatefulBuilder here
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '        التــاريــخ: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDate.date!.toLocal())}',
                        style: TextStyle(
                          fontFamily: 'myFont',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("الــطــفــل",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                      Container(
                        width: size.width * 0.5,
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
                            items: children
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                                ch = value!;
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
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryLightColor, // Change this color to your desired border color
                                        width:
                                            2.0, // Change this width if needed
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryColor, // Border color when focused
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return item.value
                                    .toString()
                                    .contains(searchValue);
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      Text("الأخــصـــائــيــة",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                      Container(
                        width: size.width * 0.5,
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
                            items: specialests
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue2,
                            onChanged: (value) {
                              setState(() {
                                selectedValue2 = value!;
                                sp = value!;
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
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryLightColor, // Change this color to your desired border color
                                        width:
                                            2.0, // Change this width if needed
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color:
                                            primaryColor, // Border color when focused
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return item.value
                                    .toString()
                                    .contains(searchValue);
                              },
                            ),
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                      Text("نــوع الجــلــســة",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                      Container(
                        width: size.width * 0.5,
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
                            items: sessions
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue3,
                            onChanged: (value) {
                              setState(() {
                                selectedValue3 = value!;
                                ss = value!;
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
                      SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        text: "حــجــز",
                        press: () {
                          color = colorMap[ss.toLowerCase()]!;
                          if (flag == true) {
                            id = selectedDate.appointments![0].id;
                            events.removeWhere((element) => element.id == id);
                          }
                          if (flag == false) autoID++;
                          id = autoID;
                          // addEvent(
                          //     id,selectedDate.date!,selectedDate.date!.add(Duration(minutes: 40)),ch,sp, ss,color);
                          // newSession= CustomEvent(id,ch,sp,ss,selectedDate.date!,selectedDate.date!.add(Duration(minutes: 40)),color);
                          // addNewSession();
                          print(ch);
                          print(sp);
                          print(ss);
                          print(events.length);
                          print(selectedDate.date);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                }),
              ),
            ));
      },
    );
  }



}


class CustomEvent {
  CustomEvent(this.id, this.child, this.specialest, this.session, this.from,
      this.to, this.color);
  int id;
  String child;
  String specialest;
  String session;
  DateTime from;
  DateTime to;
  Color color;
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
