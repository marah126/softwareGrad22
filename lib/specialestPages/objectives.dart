import 'package:flutter/material.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/specialestPages/addNewGoals.dart';
import 'package:sanad_software_project/specialestPages/doneGoals.dart';
import 'package:sanad_software_project/specialestPages/evaluatingGoals.dart';
import 'package:sanad_software_project/specialestPages/objectivesSp.dart';
import 'package:sanad_software_project/theme.dart';

class goals extends StatefulWidget {
  final String childId;
  final String spId;

  const goals({super.key, required this.childId, required this.spId});
  @override
  _goalsState createState() => _goalsState();
}

class _goalsState extends State<goals> {
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
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            // Positioned.fill(
            //   child: Image.asset(
            //     'images/backSessions.png',
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton(
                    color: primaryLightColor,
                    text: "الأهـداف الـحـالـيـة",
                    textColor: primaryColor,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => objectives(spId: "",childId: "",),
                        ),
                      );
                    },
                  ),
                  RoundedButton(
                    color: primaryLightColor,
                    text: "الأهـداف الـمنـجـزة بـالـكـامـل",
                    textColor: primaryColor,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => doneGoals(spId: "",childId: "",),
                        ),
                      );
                    },
                  ),
                  RoundedButton(
                    color: primaryLightColor,
                    text: "تـقـيـيـم الأهـداف",
                    textColor: primaryColor,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => evalobjec(),
                        ),
                      );
                    },
                  ),
                  RoundedButton(
                    color: primaryLightColor,
                    text: "إضافـة أهـداف جـديـدة",
                    textColor: primaryColor,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => newGoals(childId: "",spId: "",),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}