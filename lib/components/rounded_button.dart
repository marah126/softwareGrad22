import 'package:flutter/material.dart';
import 'package:sanad_software_project/theme.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color;
  final Color textColor;

  RoundedButton({
    required this.text,
    required this.press,
    this.color = primaryColor,
    this.textColor=Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(29),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: Offset(0, 3), // Offset
                ),
              ],
            ),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
            shadowColor: Colors.black,
            elevation: 10,
            primary: color, // Color of the text (textColor)
            backgroundColor: color, // Background color of the button
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(29)),
            ),
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor,fontFamily: 'myFont',fontSize: 20,fontWeight: FontWeight.bold),

          ),
        ),
      ),
    );
  }
}
