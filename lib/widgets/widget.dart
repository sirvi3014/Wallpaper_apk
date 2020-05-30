
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterappxwalls/model/wallpaper_model.dart';
import 'package:flutterappxwalls/views/image_view.dart';

Widget brandName()
{
  return RichText(textAlign:TextAlign.center,
    text: TextSpan
      (
      style: TextStyle(fontSize: 16),
      children: <TextSpan>[
        TextSpan(text: 'Back', style: TextStyle(color: Colors.white ,fontSize: 25,fontWeight: FontWeight.w500)),
        TextSpan(text: 'loop',style: TextStyle(color: Colors.blue,fontSize:21,fontWeight: FontWeight.w900)),
      ],
    ),
  );

}

Widget wallpapersList({List<WallpaperModel> wallpapers,context})
{

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child:GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
        crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children:wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>ImageView(
                  imgUrl: wallpaper.src.portrait,
                )
              ));
            },
            child: Hero(
              tag: wallpaper.src.portrait,

              child: Container(
               child:  ClipRRect(
                   borderRadius: BorderRadius.circular(16),
                   child: Image.network(wallpaper.src.portrait,fit: BoxFit.cover,)),
              ),
            ),
          ),
        );
      }).toList(),


    ) ,
  );
}