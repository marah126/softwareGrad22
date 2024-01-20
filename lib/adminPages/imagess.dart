// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:sanad_software_project/theme.dart';
// import 'dart:io';
// import 'path_provider/path_provider.dart';

// class ImageDisplayAndDownload extends StatefulWidget {
//   final String imageUrl;

//   ImageDisplayAndDownload({required this.imageUrl});

//   @override
//   _ImageDisplayAndDownloadState createState() => _ImageDisplayAndDownloadState();
// }

// class _ImageDisplayAndDownloadState extends State<ImageDisplayAndDownload> {
//   Future<void> _downloadImage() async {
//     try {
//       var response = await http.get(Uri.parse(widget.imageUrl));
//       final downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;

//       final file = File('${downloadsDirectory.path}/downloaded_image.png');

//       await file.writeAsBytes(response.bodyBytes);

//       print('Image saved to ${file.path}');
//     } catch (error) {
//       print('Error downloading image: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Display and Download'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image.network(
//               widget.imageUrl,
//               height: 200.0,
//               width: 200.0,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _downloadImage,
//               child: Text('Download Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: ImageDisplayAndDownload(
//       imageUrl: '$ip/sanad/getIDImageChild?id=147852369', // Replace with your actual image URL
//     ),
//   ));
// }
