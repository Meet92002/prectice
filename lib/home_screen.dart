import "dart:convert";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:http/http.dart'as http;
import "model/images_model.dart";


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void tmpFunction() {
  print('Function Called.');

}


double _value = 10;

class _HomeScreenState extends State<HomeScreen> {

  Future<ImagListModel?> imageApiCall() async{
    try{
      var request = http.Request('GET',Uri.parse('https://picsum.photos/v2/list?page=2&limit=100'));
      http.StreamedResponse response=await request.send();
      if(response.statusCode == 200){
        var jsonResponse = jsonDecode(await response.stream.bytesToString());
        return ImagListModel.fromJson(jsonResponse);
      }else{
        print("Error:");
      }
    } on Exception catch (e){
      print("error:$e");
    }
    return null;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Task 1'),
      ),
      // body: FutureBuilder<ImagListModel?>(
      //   future: imageApiCall(),
      //   builder: (context,snapshot){
      //     if(!snapshot.hasData){
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     else{
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 1,
                    ),
                    child: RangeSlider(
                    min: 0.0,
                    max: 4.0,
                    onChanged: _onchange ,
                    values:state.value,
                    onChangeEnd =_onChangeEnd,
                    inactiveColor:Colors.grey,
                    activeColor:Theme.of(state.context)accentColor),),

                  Image.network(
                    'https://picsum.photos/200/300/?blur',
                    // snapshot.data!.url!.toString(),
                    height: 400,
                    width: 390,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: Container(
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: ElevatedButton(

                        onPressed: tmpFunction,
                        child: Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 22
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          // }
        // }
      );




    // );
  }
}
