import 'package:flutter/material.dart';
import 'package:sanad_software_project/theme.dart';

class RoundedTextField2 extends StatelessWidget {
  final Widget child;
  final double width;

  RoundedTextField2({
    required this.child,
    required this.width,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        // boxShadow:[ BoxShadow(
        //   color: Colors.grey.withOpacity(0.4), // Shadow color
        //           spreadRadius: 2, // Spread radius
        //           blurRadius: 5, // Blur radius
        //           offset: Offset(0, 3), // Offset
        // )],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
