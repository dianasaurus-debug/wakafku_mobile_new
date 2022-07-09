import 'dart:convert';

import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/widgets/category_tile.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/material.dart';

class IndexCategory extends StatefulWidget {
  @override
  IndexCategoryState createState() {
    return IndexCategoryState();
  }
}

class IndexCategoryState extends State<IndexCategory> {
  @override
  void initState() {
    super.initState();
  }
  List<Widget> _menus = [
    Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment : MainAxisAlignment.center,
        children : [
          AspectRatio(
            aspectRatio: 18.0 / 12.0,
            child: Image.asset('images/wedding-card.png'),
          ),
          SizedBox(
              height : 5
          ),
          Text('Undangan', style : TextStyle(color : Colors.black54, fontSize : 18))
        ]
    ),
    Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment : MainAxisAlignment.center,
        children : [
          AspectRatio(
            aspectRatio: 18.0 / 12.0,
            child: Image.asset('images/party.png'),
          ),
          SizedBox(
              height : 5
          ),
          Text('Acara', style : TextStyle(color : Colors.black54, fontSize : 18))
        ]
    ),
    Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment : MainAxisAlignment.center,
        children : [
          AspectRatio(
            aspectRatio: 18.0 / 12.0,
            child: Image.asset('images/rings.png'),
          ),
          SizedBox(
              height : 5
          ),
          Text('Prosesi', style : TextStyle(color : Colors.black54, fontSize : 18))
        ]
    ),
    Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment : MainAxisAlignment.center,
        children : [
          AspectRatio(
            aspectRatio: 18.0 / 12.0,
            child: Image.asset('images/camera.png'),
          ),
          SizedBox(
              height : 5
          ),
          Text('Honey moon', style : TextStyle(color : Colors.black54, fontSize : 18))
        ]
    ),
    Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment : MainAxisAlignment.center,
        children : [
          AspectRatio(
            aspectRatio: 18.0 / 10.0,
            child: Image.asset('images/family.png'),
          ),
          SizedBox(
              height : 5
          ),
          Text('Planning', style : TextStyle(color : Colors.black54, fontSize : 18))
        ]
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SecondAppBar(appBar: AppBar(), title : 'Semua Kategori'),
        body:  Container(
            padding: EdgeInsets.all(10),
            child : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (_, index) => CategoryTile(categories[index]),
              itemCount: categories.length,
            )
          )
        );
  }
}
