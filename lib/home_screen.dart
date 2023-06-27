import 'dart:ui';

import 'package:flutter/material.dart';

import 'fist_page.dart';
import 'model/images_model.dart';


class HomeScreen extends StatefulWidget {
   String? title;
   ImageListModel? imagedata;
   HomeScreen({
    @required this.title,
     @required this.imagedata,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
List<ImageListModel?> imagelist = [];
class _HomeScreenState extends State<HomeScreen> {

  double blurImage = 0;
  double sigmaX = 0;
  double sigmaY = 0;
  int num = 1;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.imagedata!.toString());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    appBar: AppBar(
      title: Text(widget.title!),
    ),
    body:ListView(
            padding: EdgeInsets.all(16),
            children: [
              buildBlurredImage(),
              const SizedBox(height:0),
              Slider(
                value: blurImage,
                max: 10,
                onChanged: (value) => setState(() => blurImage = value),
              ),
              ElevatedButton(
                child: Text('Next image'),
                onPressed: () {
                  setState(() {
                    num++;
                  });
                },
              ),
            ],
          ),
  );

  Widget buildBlurredImage() => ClipRRect(

    borderRadius: BorderRadius.circular(24),
    child: Stack(
      children: [
        Container(
          height: 600,
          width: 450,
          child: Image.network(widget.imagedata!.downloadUrl.toString(),
            // 'https://picsum.photos/id/25/200/300/?blur=$blurImage&$id&$num',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurImage,
              sigmaY: blurImage,
            ),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
        ),
      ],
    ),
  );
}
