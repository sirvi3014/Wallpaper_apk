import 'dart:ui';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
class ImageView extends StatefulWidget {

   String imgUrl;
  ImageView({@required this.imgUrl});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Hero(
          tag: widget.imgUrl,
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.imgUrl,fit: BoxFit.cover,)),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
            GestureDetector(
              onTap: ()
                  {
                    _save();

                  },
              child: Stack(
                children: <Widget>[
                  Container(
                 height: 50,
                 //decoration: BoxDecoration(
                   //borderRadius: BorderRadius.circular(30)),
                    color: Color(0xff1C1B1B).withOpacity(0.8),

                 width: MediaQuery.of(context).size.width/2
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/2,

                   // padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white54,width: 1),
                        borderRadius: BorderRadius.circular(430),
                       gradient: LinearGradient(
                           colors: [
                             Color(0x36FFFFFF),
                             Color(0x0FFFFFFF)
                           ]
                        )
                    ),
                    child:Column(children: <Widget>[
                      Text("Set wallpaper",style: TextStyle(
                          fontSize: 16,color: Colors.white70)),
                      Text("Image will save in gallery",style: TextStyle(
                          fontSize: 10,color: Colors.white70),)
                    ],)
                    ,)
                ],
              )
            ),

              SizedBox(height: 16,),
            GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text("Cancel",style: TextStyle(color: Colors.white))),
              SizedBox(height: 50,)
          ],),
        )
      ],),
    );
  }
  _save() async {
    if (Platform.isAndroid)
      {
        await _askPermission();
      }
    var response = await Dio().get(
        widget.imgUrl,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);

  }

  _askPermission() async {

    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    print(statuses[Permission.location]);
  }
}
