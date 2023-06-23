// import "dart:convert";
// import 'dart:core';
// import "package:flutter/cupertino.dart";
// import "package:flutter/material.dart";
// import 'package:http/http.dart'as http;
// import "model/images_model.dart";
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// void tmpFunction() {
//   print('Function Called.');
//
// }
// List<ImagListModel?> imagelist =[];
//
//
// double _value = 10;
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   Future<List<ImagListModel?>> imageApiCall() async {
//     try {
//       var request = http.Request(
//           'GET', Uri.parse('https://picsum.photos/v2/list?page=2&limit=100'));
//       http.StreamedResponse response = await request.send();
//       print('Responsecode'+ response.statusCode.toString());
//       if (response.statusCode == 200) {
//         var jsonResponse =await jsonDecode(response.toString())as List;
//         print('jsonrespone ::s'+ jsonResponse.toString());
//
//         imagelist = jsonResponse.map((imagListModel)=>ImagListModel.fromJson(imagListModel)).toList();
//         return imagelist;
//       } else {
//         print("Error:");
//       }
//     } on Exception catch (e) {
//       print("error:$e");
//     }
//     return imagelist;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Task 1'),
//       ),
//       body: FutureBuilder<ImagListModel?>(
//           future: imageApiCall(),
//           builder: (context, snapshot) {
//             print(snapshot.data.toString());
//             if (!snapshot.hasData) {
//               return Center(child: CircularProgressIndicator());
//             }
//             else {
//               return SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Slider(
//                       min: 0.0,
//                       max: 100.0,
//                       value: _value,
//                       onChanged: (value) {
//                         setState(() {
//                           _value = value;
//                         });
//                       },
//                     ),
//
//                     Image.network(
//                       // 'https://picsum.photos/200/300/?blur',
//                       snapshot.data!.url!.toString(),
//                       height: 400,
//                       width: 390,
//                       fit: BoxFit.cover,
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     SizedBox(
//                       child: Container(
//                         height: 60,
//                         width: 350,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(60),
//                         ),
//                         child: ElevatedButton(
//
//                           onPressed: tmpFunction,
//                           child: Text(
//                             'Next',
//                             style: TextStyle(
//                                 fontSize: 22
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             }
//           }
//       ),
//
//     );
//   }
// }
//




//
//
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart'as http;
import 'model/images_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double _width = 350;
  final double _height = 300;
  int _imageIndex = 0;
  double _sigmaX = 0;
  double _sigmaY = 0;
  double _blur =1;
  int num = 0;

  final images = [
    "background1.jpg",
    "background2.jpg",
    "background3.jpg"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Blur image'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ..._buildBlurSigmaAndOpacity(),
            SizedBox(height: 5),
            _buildImageContainer(),
            SizedBox(height: 5),
            ElevatedButton(
              child: Text('Next image'),
              onPressed: () {
                setState(() {
                  num++;
                  // _imageIndex = (_imageIndex + 1) % images.length;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer() {
    return BackdropFilter(

      filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos//200/300/?blur=$_blur'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  List<Widget> _buildBlurSigmaAndOpacity() {
    return [

      Text('Change blur sigmaX: ${_sigmaX.toStringAsFixed(2)}'),
      Slider(
        min: 0,
        max: 10,

        value: _sigmaX,
        label: '$_sigmaX',
        onChanged: (value) {
          setState(() {
            _sigmaX = value;
          });
        },
      ),
      SizedBox(height: 5),
      Text('Change blur sigmaY: ${_sigmaY.toStringAsFixed(2)}'),
      Slider(
        min: 0,
        max: 10,
        value: _sigmaY,
        onChanged: (value) {
          setState(() {
            _sigmaY = value;
          });
        },
      ),
      SizedBox(height: 5),
      Text('Change blur sigmaY: ${_blur.toStringAsFixed(2)}'),
      Slider(
        min: 0,
        max: 10,
        value: _blur,
        onChanged: (value) {
          setState(() {
            _blur++;
            _blur = value;
          });
        },
      ),
    ];
  }
}
