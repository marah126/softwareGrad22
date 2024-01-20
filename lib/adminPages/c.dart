// ignore_for_file: prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/components/rounded_textField.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class calenderr extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<calenderr> {

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
    'الـلغـة و نــطــق',
    'ســلــوكــي',
    'وظــيــفــي',
    'تــربـيـة خـاصـة',
    'عــلاج طــبـيـعي',
  ];
  String selectedValue = children.first;
  String selectedValue2 = specialests.first;
  String selectedValue3 = sessions.first;
  String selectedDateweek = "";
  String day="";

  List<DateTime> visibleDates = [];
  List<String> visibleDatesString = [];
  late CustomEvent newSession;

   late DateTime firstDayOfNextMonth;
   late DateTime lastDayOfCurrentMonth;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  
  Future<void> getChildrenNames() async{
    int x=0;
    if (x == 0) {
      //print("childrenssssssssssss");
      final childreNamesResponse =
          await http.get(Uri.parse(ip + "/sanad/getchname"));
      if (childreNamesResponse.statusCode == 200) {
        children.clear();
        String childName;
        final List<dynamic> data = jsonDecode(childreNamesResponse.body);

        for (int i = 0; i < data.length; i++) {
         // print(data[i]['Fname'] + " " + data[i]['Lname']);
          childName = data[i]['Fname'] + " " + data[i]['Lname'];
          setState(() {
            children.add(childName);
          });
        }
        for(int i=0;i<children.length;i++){
         // print("ch"+children[i]);
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
          //print(data2[i]['Fname'] + " " + data2[i]['Lname']);
          spName = data2[i]['Fname'] + " " + data2[i]['Lname'];
          setState(() {
            specialests.add(spName);
          });
        }
        for(int i=0;i<specialests.length;i++){
         // print("sp"+specialests[i]);
        }
      } else {
        print("errrrrrrrror");
      }
    }
  }


  Future<void> addNewSession() async {
    final response =
        await http.post(Uri.parse(ip + "/sanad/addsession"), body: {
          'id':newSession.id.toString(),
          'child': newSession.child,
          'specialest': newSession.specialest,
          'session': newSession.session,
          'date': newSession.from.toUtc().toIso8601String(),
          'endMonth':newSession.endMonth.toUtc().toIso8601String(),
          'day': ((newSession.from.weekday  == 7) ? 0 : newSession.from.weekday).toString(),
    });

    if (response.statusCode == 200) {
      print("new sesission added");
    } else {
      print(response);
    }
  }
  

  Future<void> getAllSessions()async{

    CustomEvent e;
    DateTime dd;
    DateTime endMonth;
    String s;
    final allSessions=await http.get(Uri.parse(ip+"/sanad/getallsessions"));
    if (allSessions.statusCode == 200) {
        String childName;
        final List<dynamic> data = jsonDecode(allSessions.body);
        autoID=data.length;
        print("autoid= "+autoID.toString());
        for(int i=0;i<data.length;i++){
          print(data[i]);
          dd=DateTime.parse(data[i]['date']).toLocal();
          endMonth=DateTime.parse(data[i]['endMonth']).toLocal();
          s=data[i]['session'];
          e=CustomEvent(data[i]['idd'], data[i]['child'], data[i]['specialest'], data[i]['session'], dd, dd.add(Duration(minutes: 40)), endMonth,colorMap[s.toLowerCase()]!);
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
      //_loadData();
    }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  CalendarController _calendarController = CalendarController();

  final TextEditingController textEditingController = TextEditingController();
  int autoID = 0;
  TimeOfDay timeOfDay = TimeOfDay(hour: 8, minute: 0);
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  
  void addEvent(int id, DateTime startTime, DateTime endTime, String child,
      String specialest, String session, DateTime endMonth,Color c) {
    final newEvent =
        CustomEvent(id, child, specialest, session, startTime, endTime, endMonth,c);
    events.add(newEvent);
    setState(() {
      // Refresh the calendar with the updated event data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: UniqueKey(),
          backgroundColor: primaryColor,
          onPressed: () {
            print('Floating Action Button Pressed!');

            selectedDateweek = visibleDatesString.first;
            for (int i = 0; i < visibleDates.length; i++) {
              print(visibleDates[i]);
              print(visibleDatesString[i]);
            }
            addMoreEvents(visibleDates);
          },
          child: Icon(Icons.add),
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton(
            heroTag: UniqueKey(),
            backgroundColor: primaryColor,
            onPressed: () {
              _switchCalendarView();
            
            })
      ]),
      appBar: AppBar(
        title: Text('Calendar '),
        backgroundColor: primaryColor,
      ),
      body: SfCalendar(
        appointmentBuilder:
            (BuildContext context, CalendarAppointmentDetails details) {
          final Appointment appointment = details.appointments.elementAt(0);

          return Container(
            color: appointment.color,
            child: Text(
              appointment.subject,
              style: TextStyle(
                  color: secondaryColor, fontFamily: 'myFont' // Text color
                  // Other text styles (font size, weight, etc.) can be customized here
                  ),
              maxLines: 5, // Ensure text stays on a single line
              overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
            ),
          );
        },
        controller: _calendarController,
        view: CalendarView.week,
        timeSlotViewSettings: TimeSlotViewSettings(
          timeInterval: Duration(minutes: 40),
          timeFormat: 'h:mm',
          startHour: 8,
          endHour: 18,
          timeIntervalHeight: 100,
          //numberOfDaysInView:6
        ),
        cellBorderColor: Color(0xff9990b3),
        todayHighlightColor: primaryColor,
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: primaryColor, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
        ),
        showNavigationArrow: true, // اسهم التحرك من اسبوع لاسبوع
        showDatePickerButton: true,
        dataSource: _getCalendarAppointments(),
        firstDayOfWeek: 7,
        allowViewNavigation: true,
        viewHeaderStyle: ViewHeaderStyle(
          backgroundColor: primaryLightColor,
        ),
        headerStyle: CalendarHeaderStyle(backgroundColor: primaryLightColor),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.appointment) {
            showdetailesDialog(details);
            // showEventInputDialog(details,false);
          } else {
            showEventInputDialog(details, false);
            //showdetailesDialog(details);
            // print(details.appointments!.length);
            // print(details.appointments![0].id);
            // print("object");
          }
        },
        onViewChanged: (ViewChangedDetails viewChangedDetails) {
          visibleDates = viewChangedDetails.visibleDates;
          visibleDatesString = [];
          String s = "";
          for (int i = 0; i < visibleDates.length; i++) {
            s = (DateFormat('MM/dd').format(visibleDates[i]).toString());
            //s=visibleDates[i].toString();
            visibleDatesString.add(s);
          }
        },
      ),
    );
  }

  CalendarDataSource _getCalendarAppointments() {
   // DateTime d = DateTime.now();
   // DateTime firstDayOfNextMonth = DateTime(d.year, d.month + 1, 1);
   // DateTime lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
   // d = d.add(const Duration(days: 10));
    final List<Appointment> appointments = <Appointment>[];

    for (final CustomEvent event in events) {
      appointments.add(Appointment(
          id: event.id,
          startTime: event.from,
          endTime: event.to,
          subject: event.child,
          color: event.color,
          recurrenceRule: 'FREQ=DAILY;INTERVAL=7;UNTIL=${event.endMonth}'));

          print("appointments= "+appointments.length.toString());
    }
    return _DataSource(appointments);
  }

  void _switchCalendarView() {
    // Toggle between 'week' and 'day' views
    if (_calendarController.view == CalendarView.week) {
      _calendarController.view = CalendarView.day;
    } else {
      _calendarController.view = CalendarView.week;
    }
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
                          firstDayOfNextMonth = DateTime(selectedDate.date!.year, selectedDate.date!.month + 1, 1);
                          lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
                          addEvent(
                              id,selectedDate.date!,selectedDate.date!.add(Duration(minutes: 40)),ch,sp, ss,lastDayOfCurrentMonth,color);
                          newSession= CustomEvent(id,ch,sp,ss,selectedDate.date!,selectedDate.date!.add(Duration(minutes: 40)),lastDayOfCurrentMonth,color);
                          addNewSession();
                          // print(ch);
                          // print(sp);
                          // print(ss);
                          print("from reserve button"+events.length.toString());
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

  void showdetailesDialog(CalendarTapDetails selectedDate) {
    int id = selectedDate.appointments![0].id;
    print("insidee $id");
    CustomEvent e = events.firstWhere((element) => element.id == id);
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: primaryLightColor,
              content: Container(
                  color: primaryLightColor,
                  width: size.width * 0.5,
                  height: size.height * 0.5,
                  child: SingleChildScrollView(
                      child: StatefulBuilder(builder: (context, setState) {
                    // Use StatefulBuilder here
                    return Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        '        التــاريــخ: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedDate.date!.toLocal())}',
                        style: TextStyle(
                          fontFamily: 'myFont',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("الطــفــل",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'myFont',
                              fontWeight: FontWeight.bold,
                              color: secondaryColor)),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color:
                                primaryColor, // Change this color to your desired border color
                            width: 2.0, // Adjust the width as needed
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the border radius as needed
                        ),
                        child: Text(
                          e.child, textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'myFont',
                              color:
                                  secondaryColor), // Adjust the font size and other styles as needed
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("الأخــصــائــيــة",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'myFont',
                              fontWeight: FontWeight.bold,
                              color: secondaryColor)),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color:
                                primaryColor, // Change this color to your desired border color
                            width: 2.0, // Adjust the width as needed
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the border radius as needed
                        ),
                        child: Text(
                          e.specialest, textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'myFont',
                              color:
                                  secondaryColor), // Adjust the font size and other styles as needed
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("نـوع الـجـلـسـة",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'myFont',
                              fontWeight: FontWeight.bold,
                              color: secondaryColor)),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color:
                                primaryColor, // Change this color to your desired border color
                            width: 2.0, // Adjust the width as needed
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the border radius as needed
                        ),
                        child: Text(
                          e.session, textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'myFont',
                              color:
                                  secondaryColor), // Adjust the font size and other styles as needed
                        ),
                      ),
                      SizedBox(height: 17),
                      RoundedButton(
                          text: "تــعــديــل",
                          press: () {
                            Navigator.pop(context);
                            showEventInputDialog(selectedDate, true);
                          }),
                    ]);
                  }))));
        });
  }

  void addMoreEvents(List<DateTime> vdates) {
    int id;
    Color color;
    Size size = MediaQuery.of(context).size;
    String ch = "";
    String sp = "";
    String ss = "";
    String h = timeOfDay.hour.toString();
    String m = timeOfDay.minute.toString();
    String dd = visibleDatesString.first;
    DateTime datedate;
    if (timeOfDay.hour > 12) {
      int hh = timeOfDay.hour;
      hh = hh - 12;
      setState(
        () => h = hh.toString(),
      );
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
              height: size.height * 0.7,
              child: SingleChildScrollView(
                child: StatefulBuilder(builder: (context, setState) {
                  // Use StatefulBuilder here
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ' التــاريــخ:',
                        style: TextStyle(
                          fontFamily: 'myFont',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Container(
                        width: size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: visibleDatesString
                                .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, fontFamily: 'myFont'),
                                      ),
                                    ))
                                .toList(),
                            value: selectedDateweek,
                            onChanged: (value) {
                              setState(() {
                                selectedDateweek = value!;
                                dd = value!;
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
                        height: 15,
                      ),
                      Text("الــوقــــت",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'myFont',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 14, right: 14),
                        width: size.width * 0.5,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: primaryColor, width: 2),
                            color: Colors.white),
                        child: GestureDetector(
                          child: Text(h + ':' + m),
                          onTap: () async {
                            TimeOfDay? newtime = await showTimePicker(
                                context: context, initialTime: timeOfDay);
                            if (newtime == null) return;
                            setState(
                              () => timeOfDay = newtime,
                            );
                            setState(
                              () => m = timeOfDay.minute.toString(),
                            );
                            setState(() => h = timeOfDay.hour.toString());
                            if (timeOfDay.hour > 12) {
                              int hh = timeOfDay.hour;
                              hh = hh - 12;
                              setState(
                                () => h = hh.toString(),
                              );
                            }
                          },
                        ),
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
                          autoID++;
                          id = autoID;
                          int index = visibleDatesString.indexOf(dd);
                          datedate = visibleDates[index];
                          datedate = new DateTime(datedate.year, datedate.month,
                              datedate.day, timeOfDay.hour, timeOfDay.minute);

                          firstDayOfNextMonth = DateTime(datedate.year, datedate.month + 1, 1);
                          lastDayOfCurrentMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
                          addEvent(
                              id,datedate,datedate.add(Duration(minutes: 40)),ch,sp,ss, lastDayOfCurrentMonth,color);
                          newSession= CustomEvent(id,ch,sp,ss,datedate,datedate.add(Duration(minutes: 40)),lastDayOfCurrentMonth,color);
                          addNewSession();
                          print(ch);
                          print(sp);
                          print(ss);
                          print(events.length);
                          print(datedate);
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
      this.to, this.endMonth, this.color);
  int id;
  String child;
  String specialest;
  String session;
  DateTime from;
  DateTime to;
  DateTime endMonth;
  Color color;
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
