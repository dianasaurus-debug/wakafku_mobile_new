import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/screens/map/recommendation.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/program_tile_horizontal.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as LocationManager;

class ListProgramPage extends StatefulWidget {
  @override
  _ListProgramPageState createState() => _ListProgramPageState();
}

class _ListProgramPageState extends State<ListProgramPage> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
      AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios_rounded, color: CustomColor.themedarker, size: 25),
          onTap: () => Navigator.of(context).pop(),
        ),
        toolbarHeight: 90,
        elevation: 0,
        title: Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Column(
              children: [
                Text('Program Wakaf Terdekat', style: CustomFont.orangeMedBold),
                SizedBox(height : 5),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    filled: true,
                    isDense: true,
                    fillColor: CustomColor.white1,
                    suffixIcon: GestureDetector(
                      onTap: (){

                      },
                      child :  Icon(Icons.filter_list_alt, color: CustomColor.theme),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left : 10, right: 10),
                      child: Icon(CupertinoIcons.search, color: CustomColor.themedarkest),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 25,
                      minHeight: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    hintStyle: CustomFont.blackSmallight,
                    hintText: ' Cari Program Wakaf',
                  ),
                )
              ],
            )
        ),
      ),
      body:
      Column(
        children: [
          Row(
            children: [
              Expanded(
                  child : ElevatedButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Peta".toUpperCase(),
                                style: CustomFont.textInfoWhiteLight),
                          ]),
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          elevation: MaterialStateProperty.all<double>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(CustomColor.theme),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)))
                      ),
                      onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendationPage()))
                      })
              ),
              Expanded(
                  child : ElevatedButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Daftar".toUpperCase(),
                                style: CustomFont.textInfoWhiteLight),
                          ]),
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          elevation: MaterialStateProperty.all<double>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColor.themedarker),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0)))),
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ListProgramPage()))

                      })
              ),
            ],
          ),
          SizedBox(height : 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: programs.length,
              itemBuilder: (BuildContext context, int index) {
                return ProgramTileHorizontal(programs[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
