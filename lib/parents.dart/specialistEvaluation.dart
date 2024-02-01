// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/theme.dart';

class spEvaluation extends StatefulWidget {
  final String id;

  const spEvaluation({super.key, required this.id});
  @override
  _spEvaluationState createState() => _spEvaluationState();
}

class _spEvaluationState extends State<spEvaluation> {
  String selectedValue = 'ساره خالد وليد حنو';
  String svaluee = 'ساره خالد وليد حنو';
  List<String> SP = [
    'ساره خالد وليد حنو',
    'وليد خالج وليد حنو',
    'لميس خالد وليد حنو',
    'مجد خالج وليد حنو',
  ];
  double _rating1 = 0;
  double _rating2 = 0;
  double _rating3 = 0;
  double _rating4 = 0;
  double _rating5 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('تـقـيـيـم الأخـصـائـيـن',style: TextStyle(fontFamily: 'myfont',fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10),
                  Expanded(
                    child: Center(
                      child: DropdownButton<String>(
                        value: svaluee,
                        items: SP.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            svaluee = newValue!;
                          });
                        },
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                        dropdownColor: Colors.grey[200],
                        elevation: 2,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'اخـتـيـار أخـصـائـي',
                    style: TextStyle(
                      fontFamily: 'myfont',
                      fontSize: 22,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(height: 70),
              Container(
                //  height: 80,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),

                color: Color.fromARGB(255, 243, 236, 238),
                child: Column(
                  children: <Widget>[
                    Text(
                      ' كـيـف تـقـيـم تـواصـل الأخـصـائـي مـعـك ومـع طـفـلـك؟',
                      style: TextStyle(fontFamily: 'myfont', fontSize: 20),
                      textAlign: TextAlign.end,
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingBar.builder(
                      initialRating: _rating1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 20,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating1 = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                width: double.infinity,
                color: Color(0xffe6f6ff),
                child: Column(
                  children: <Widget>[
                    Text(
                      'إلـى أي مـدى الأخـصـائـي يـفـهـم احـتـيـاجـات طـفـلـك؟',
                      style: TextStyle(fontFamily: 'myfont', fontSize: 20),
                      textAlign: TextAlign.end,
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingBar.builder(
                      initialRating: _rating3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 20,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating3 = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                width: double.infinity,
                color: Color.fromARGB(255, 242, 239, 193),
                child: Column(
                  children: <Widget>[
                    Text(
                      'مـا مـدى فـعـالـيـةالأخـصـائـي فـي تـقـدم طـفـلـك؟',
                      style: TextStyle(fontFamily: 'myfont', fontSize: 20),
                      textAlign: TextAlign.end,
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingBar.builder(
                      initialRating: _rating2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 20,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating2 = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                width: double.infinity,
                color: Color(0xfffff9e6),
                child: Column(
                  children: <Widget>[
                    Text(
                      'مـا مـدى جـودة تـنـظـيـم الأخـصـائـي الـجـلـسـات ؟',
                      style: TextStyle(fontFamily: 'myfont', fontSize: 20),
                      textAlign: TextAlign.end,
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingBar.builder(
                      initialRating: _rating4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 20,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating4 = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                width: double.infinity,
                color: Color(0xffebffe5),
                child: Column(
                  children: <Widget>[
                    Text(
                      'هــل تـوصـي بـهـذا الـمـتـخـصـص ؟',
                      style: TextStyle(fontFamily: 'myfont', fontSize: 20),
                      textAlign: TextAlign.end,
                      maxLines: 2, // Set the maximum number of lines
                      overflow: TextOverflow.ellipsis,
                    ),
                    RatingBar.builder(
                      initialRating: _rating5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemSize: 20,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating5 = rating;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              RoundedButton(
                color: primaryColor,
                text: "تـخـزيـن ",
                textColor: Colors.white,
                press: () {},
              ),
            ],
          )),
    );
  }
}