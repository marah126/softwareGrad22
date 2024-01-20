// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:sanad_software_project/theme.dart';
class calendar extends StatefulWidget{
  final String text;

  const calendar({super.key, required this.text});
  @override
  State<StatefulWidget> createState() {
    return _calenderState();
  }

}
class _calenderState extends State<calendar> {
  late String text;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text=widget.text;
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(backgroundColor: primaryColor),
        body: Container(
          width: double.infinity,
          height: size.height*0.5,
          child: Text(text)
    ));
  }

  CalendarDataSource _getCalendarAppointments() {
    final List<Appointment> appointments = <Appointment>[];
    final List<CustomEvent> events = getCustomEvents();

    for (final CustomEvent event in events) {
      appointments.add(Appointment(
        startTime: event.from,
        endTime: event.to,
        subject: event.eventName,
        color: event.color,
      ));
    }

    return _DataSource(appointments);
  }
}

class CustomEvent {
  CustomEvent(this.eventName, this.from, this.to, this.color);

  String eventName;
  DateTime from;
  DateTime to;
  Color color;
}

List<CustomEvent> getCustomEvents() {
  return <CustomEvent>[
    CustomEvent('Event 1', DateTime(2023, 10, 25, 10, 0),
        DateTime(2023, 10, 25, 12, 0), Colors.blue),
    CustomEvent('Event 2', DateTime(2023, 10, 26, 14, 0),
        DateTime(2023, 10, 26, 16, 0), Colors.green),
    // Add more events as needed
  ];
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}