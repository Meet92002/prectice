import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:imagechangeing/home_screen.dart';
import 'package:http/http.dart' as http;
import 'model/images_model.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

List<ImageListModel?> imagelist = [];

class _FirstPageState extends State<FirstPage> {
  @override
  initState() {
    print('hello');
    imageApiCall();
  }

  Future<List<ImageListModel?>?> imageApiCall() async {
    try {
      // var request = http.Request(
      //     'GET', Uri.parse('https://picsum.photos/v2/list?page=2&limit=100'));
      // http.StreamedResponse response = await request.send();
      final response =await http.get(Uri.parse('https://picsum.photos/v2/list?page=2&limit=100'));
      print('Responsecode' + response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonResponse = await jsonDecode(response.body.toString())as List;
        print('jsonrespone ::s' + jsonResponse.toString());

        imagelist = jsonResponse.map((imagListModel) => ImageListModel.fromJson(imagListModel)).toList();

        print(imagelist.length.toString());
        return imagelist;
      } else {
        print("Error:");
      }
    } on Exception catch (e) {
      print("error:$e");
    }
    return imagelist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('All Details'),

      ),
      body: FutureBuilder<List<ImageListModel?>?>(
          future: imageApiCall(),
          builder: (context, snapshot) {
            print(snapshot.data.toString());
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            else {
              return SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  title: 'Blure Effect',imagedata: imagelist[index],
                                )));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height *0.16,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch ,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Id :' +
                                          imagelist[index]!.id!.toString()),
                                      Text('Author :' +
                                          imagelist[index]!.author!.toString()),
                                      SizedBox(height: 12),
                                      CircleAvatar(
                                        radius: 32,
                                        backgroundImage: NetworkImage(
                                            imagelist[index]!.downloadUrl!.toString()),
                                        // backgroundColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                  // VerticalDivider(
                                  //   indent: 30,
                                  //   endIndent: 30,
                                  //   thickness: 1,
                                  //   width: 20,
                                  //   color: Colors.black.withOpacity(.2),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 60,right: 30),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('Download_Url :'),
                                              // Text(imagelist[index]!
                                              //     .downloadUrl!
                                              //     .toString()),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Text('Height :' +
                                        imagelist[index]!.height!.toString() +
                                        ' ' +
                                        'width :' +
                                        imagelist[index]!.width!.toString()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
            }
          }),

    );
  }
}