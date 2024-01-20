import 'package:flutter/material.dart';


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp();
//   }
// }

// class MyImageRadioButtons extends StatefulWidget {
//   @override
//   _MyImageRadioButtonsState createState() => _MyImageRadioButtonsState();
// }

// class _MyImageRadioButtonsState extends State<MyImageRadioButtons> {
//   int selectedValue = 1; // Initialize with the default selected value

//   void handleRadioValueChanged(int value) {
//     setState(() {
//       selectedValue = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           CustomImageRadioButton(
//             value: 1,
//             groupValue: selectedValue,
//             onChanged: handleRadioValueChanged,
//             image: AssetImage('assets/image1.png'), // Replace with your image path
//           ),
//           CustomImageRadioButton(
//             value: 2,
//             groupValue: selectedValue,
//             onChanged: handleRadioValueChanged,
//             image: AssetImage('assets/image2.png'), // Replace with your image path
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomImageRadioButton extends StatelessWidget {
  final String text;
  final int value;
  final int groupValue;
  final ValueChanged<int> onChanged;
  final Image image;

  CustomImageRadioButton({
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Column(
        children: <Widget>[
          Radio<int>(
            value: value,
            groupValue: groupValue,
            onChanged: (int? newValue) {
              onChanged(newValue!);
            },
          ),
          image, 
          Text(text,style: TextStyle(fontFamily: 'myFont',fontSize: 16,color: Color(0xff800080)),) // Customize the image size
        ],
      ),
    );
  }
}
