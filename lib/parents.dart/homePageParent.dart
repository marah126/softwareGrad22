// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:sanad_software_project/specialestPages/sessionNotes.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class childSchdule extends StatefulWidget {
  final String id;

  const childSchdule({super.key, required this.id});
  @override
  State<StatefulWidget> createState() {
    return childSchduleState();
  }
}

class childSchduleState extends State<childSchdule> {
  late String id;

  List<CustomEvent> events = [];
  Map<String, Color> colorMap = {
    'الـلغـة و نــطــق': primaryLightColor,
    'ســلــوكــي': Color(0xffb1a1b3),
    'وظــيــفــي': Color(0xfffff9e6),
    'تــربـيـة خـاصـة': Color(0xffe6f6ff),
    'عــلاج طــبـيـعي': Color(0xffEBFFE5)
  };

  static const List<String> sessions = [
    'الـلغـة و نــطــق',
    'ســلــوكــي',
    'وظــيــفــي',
    'تــربـيـة خـاصـة',
    'عــلاج طــبـيـعي',
  ];

  @override
  void initState() {
    super.initState();
    id = widget.id;
    print("home parent id " + id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        localizationsDelegates: [
          SfGlobalLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar'),
        ],
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff6f35a5),
            automaticallyImplyLeading: false,
            title: Text(
              "بـرنــاج طــفــلــيي",
              style: TextStyle(
                  fontFamily: 'myFont',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: Container(
            width: size.width,
            height: size.height,
            child: SfCalendar(
              dataSource: _getCalendarAppointments(),
              view: CalendarView.schedule,
              todayHighlightColor: primaryColor,
              scheduleViewSettings: ScheduleViewSettings(
                appointmentItemHeight: 200,
                hideEmptyScheduleWeek: true,
                appointmentTextStyle: TextStyle(
                    color: Colors.black, fontFamily: 'myFont', fontSize: 16),
                weekHeaderSettings: WeekHeaderSettings(
                  startDateFormat: " ",
                  endDateFormat: " ",
                ),
                dayHeaderSettings: DayHeaderSettings(
                    dayTextStyle: TextStyle(color: primaryColor, fontSize: 19)),
                monthHeaderSettings: MonthHeaderSettings(
                    monthTextStyle: TextStyle(
                        color: primaryLightColor, fontWeight: FontWeight.bold),
                    backgroundColor: secondaryColor),
              ),
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.appointment) {
                  //showEventInputDialog(details,false);
                  // showEventInputDialog(details,false);
                }
              },
            ),
          ),
        ));
  }

  CalendarDataSource _getCalendarAppointments() {
    DateTime d = DateTime.now();
    DateTime firstDayOfNextMonth = DateTime(d.year, d.month + 1, 1);
    DateTime lastDayOfCurrentMonth =
        firstDayOfNextMonth.subtract(Duration(days: 1));
    // d = d.add(const Duration(days: 10));
    final List<Appointment> appointments = <Appointment>[];

    for (final CustomEvent event in events) {
      appointments.add(Appointment(
          id: event.id,
          startTime: event.from,
          endTime: event.to,
          subject: event.child +
              "  --  " +
              event.specialest +
              "  --  " +
              event.session,
          color: event.color,
          recurrenceRule:
              'FREQ=DAILY;INTERVAL=7;UNTIL=$lastDayOfCurrentMonth'));
    }
    return _DataSource(appointments);
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
