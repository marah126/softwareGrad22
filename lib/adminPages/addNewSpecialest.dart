// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sanad_software_project/components/roundedTextFeild2.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;


class newSpecialest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _newSpecialestState();
  }
}

class _newSpecialestState extends State<newSpecialest> {
  static const List<String> sessions = [
    'سلوكي',
    'وظيفي',
    'تربية خاصة',
    'علاج طبيعي',
    'اللغة و النطق ',
  ];
  String selectedValue3 = sessions.first;
  String ss="";
  String startDate="select Date";
  bool date=false;
  bool checked=false;
  DateTime selectedDate1 = DateTime.now();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController secnameController = TextEditingController();
  final TextEditingController thnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();


  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print(pickedFile.path);
      });
    }
  }
  File? _file;

  Future<void> _getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    setState(() {
      if (result != null) {
        _file = File(result.files.single.path!);
      }
    });
  }



  Future<void> _selectDate(BuildContext context, int pickerNumber) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: primaryColor, // Change this color as needed
            colorScheme: ColorScheme.light(primary: primaryColor), // Change this color as needed
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    
    );

    if (picked != null) {
      setState(() {
        selectedDate1 = picked;
        date=true;
        startDate=DateFormat('yyyy/MM/dd').format(selectedDate1.toLocal());
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) {
      print('No image selected');
      return;
    }

    final url = Uri.parse(ip+'/sanad/uploadSP'); // Replace with your server's IP
    var request = http.MultipartRequest('POST', url);
    request.fields['spID'] = idController.text;
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      }else if(response.statusCode==201){
        print(response.stream);
      }
       else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> _uploadFile() async {

    if (_file == null) {
      // Handle case where no file is selected
      return;
    }
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ip + '/sanad/uploadfileSP'),
    );
    // Add file to the request
    request.fields['spID'] = idController.text;
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        _file!.path,
        contentType: MediaType('application', 'pdf'),
      ),
    );
    // Send the request
    var response = await request.send();
    // Check the server response
    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print('File upload failed with status ${response.statusCode}');
    }
  }

  Future<void> addSpecialestInfo()async{
    final response = await http.post(Uri.parse(ip+"/sanad/addSpecialestInfo"),body: {
      'fname': fnameController.text,
          'secname':secnameController.text,
          'thname':thnameController.text,
          'lname':lnameController.text,
          'id': idController.text,
          'startDate': startDate,
          'phone': phoneController.text,
          'address': addressController.text,
          'specialise': ss,
          
    });

    if(response.statusCode==200){
      print("Done");
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("نــجــاح",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20),),
          icon: Icon(Icons.done,color: Colors.green,),
          content: Text("تــم إضــافــة أخــصــائـي جــديــد بــنــجــاح",style: TextStyle(fontFamily: 'myFont',fontSize: 18),textAlign: TextAlign.left,),
        );
      });
    }else{
      print("error");
    }
  }

  void check(BuildContext context){
  if(fnameController.text.trim().isEmpty ||
    secnameController.text.trim().isEmpty || 
    thnameController.text.trim().isEmpty || 
    lnameController.text.trim().isEmpty || 
    idController.text.trim().isEmpty || 
    phoneController.text.trim().isEmpty||
    addressController.text.trim().isEmpty||
    ss.trim().isEmpty || date==false ){

      checked=false;
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("تــحــذيــر",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20),),
          icon: Icon(Icons.error,color: Colors.red,),
          content: Text("يــجــب تــعــبــئــة جــمــيــع الــحــقـــول",style: TextStyle(fontFamily: 'myFont',fontSize: 18),textAlign: TextAlign.left,),
        );
      });
    }
    else if(idController.text.length!=9){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("تــحــذيــر",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20),),
          icon: Icon(Icons.error,color: Colors.red,),
          content: Text("رقــم الــهويــة يــجــب ان يــكــون 9 أرقــام",style: TextStyle(fontFamily: 'myFont',fontSize: 18),textAlign: TextAlign.left,),
        );
      });
    }
    else if (phoneController.text.length <10){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("تــحــذيــر",style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20),),
          icon: Icon(Icons.error,color: Colors.red,),
          content: Text("رقــم الهــاتــف أقــل مـــن 10 خــانــات",style: TextStyle(fontFamily: 'myFont',fontSize: 18),textAlign: TextAlign.left,),
        );
      });
    }
      else{
      checked=true;
    }
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////

 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          "إضــافــة أخـصـائـي جــديــد",
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'myFont',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: primaryLightColor,
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Image.asset(
              "assets/images/nurses.png",
              width: size.width * 0.8,
              height: size.width * 0.5,
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        textAlign: TextAlign.right,
                        controller: fnameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "اســم الأخـصـائـي",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.person,
                    color: primaryColor,
                    )
                  ],
                ),
              ),
              Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        textAlign: TextAlign.right,
                        controller: secnameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "اســم الــأب",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        textAlign: TextAlign.right,
                        controller: thnameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "اســم الـجـد",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        textAlign: TextAlign.right,
                        controller: lnameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "اســم الـعـائـلة",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        controller: idController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "رقــم الـهــويـة",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.numbers,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.right,
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "رقــم الـهــاتـف",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.call,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                      width: size.width * 0.6,
                      child: TextField(
                        keyboardType: TextInputType.streetAddress,
                        textAlign: TextAlign.right,
                        controller: addressController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                  Spacer(),
                  Text(
                    "عنـوان الســكـن",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.add_location,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            Card(
              color: primaryLightColor,
              child: Column(
                children:[
                  SizedBox(height: 10,),
                   Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
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
                    Spacer(),
                    Text(
                      "الـتـخـصّـص",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                    ),
                    Icon(
                      Icons.person,
                      color: primaryColor,
                    )
                  ],
                ),
                SizedBox(height: 10,),
              ]),
            ),
            Card(
              color: primaryLightColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  RoundedTextField2(
                    width: size.width*0.6,
                    child: GestureDetector(
                      child: TextField(
                        enabled: false,
                     decoration: InputDecoration(
                      hintText: startDate,
                      hintStyle: TextStyle(color: Colors.black)
                     ),),
                      onTap: () => _selectDate(context,1),
                    ),
                  ),
                  SizedBox(height: 20),
                  Spacer(),
                  Text(
                    "تـاريـخ بـدء الـعـمـل",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'myFont', fontSize: 18),
                  ),
                  Icon(
                    Icons.calendar_month,
                    color: primaryColor,
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            RoundedButton(text: "حــفــظ", press: (){
              check(context);
              if(checked){
                addSpecialestInfo();
              }
            }),
            SizedBox(height: 15,)
            ]
          )
        )
      )
    );
  }
}