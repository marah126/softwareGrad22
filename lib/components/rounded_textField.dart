import 'package:flutter/material.dart';
import 'package:sanad_software_project/theme.dart';

class RoundedTextField extends StatelessWidget {
  final Widget child;

  RoundedTextField({
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        boxShadow:[ BoxShadow(
          color: Colors.grey.withOpacity(0.4), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(0, 3), // Offset
        )],
        color: primaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
