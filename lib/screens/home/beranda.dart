import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/screens/program/categories.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/nav_drawer.dart';
import 'package:final_project_mobile/widgets/program_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: NavDrawer(),
        appBar: BaseAppBar(appBar: AppBar()),
        body:
        SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Halo, Diana',
                            style: CustomFont.orangeBigBold),
                        SizedBox(height : 8),
                        Text('Sudahkah kamu berwakaf hari ini?',
                            style: CustomFont.blackMedBold),
                      ])),
              Padding(
                padding : EdgeInsets.symmetric(vertical: 10),
                child : TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    filled: true,
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
                ),
              ),
              Container(
                height:170,
                width: double.infinity,
                padding: EdgeInsets.only(left : 20, right: 40),
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Susah menemukan program wakaf?',style: CustomFont.blackBigBold,),
                    SizedBox(height: 5,),
                    ElevatedButton(
                      style: CustomButton.buttonSubmit,
                      onPressed: (){

                      },
                      child: Text('Cari disini', style: CustomFont.whiteMedBold,),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                  image: DecorationImage(
                    opacity: 0.6,
                    image: AssetImage("lib/assets/images/mosque_pic.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kategori', style: CustomFont.blackMedBold),
                    SizedBox(height : 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: categories.map((e) =>
                            GestureDetector(
                              onTap: (){
                                Route route = MaterialPageRoute(builder: (context) => IndexCategory());
                                Navigator.push(context, route);
                              },
                              child : Container(
                                  margin: EdgeInsets.only(right: 5),
                                  width: 75,
                                  child : Column(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                                            color: Colors.tealAccent.withOpacity(0.3),
                                          ),
                                          width: 70,
                                          height: 60,
                                          padding: EdgeInsets.all(10),
                                          child: Icon(FontAwesomeIcons.building)
                                      ),
                                      SizedBox(height: 3),
                                      Text(e.name)
                                    ],
                                  )
                              )
                            )

                          )
                              .toList())
                    ),
                  ],
                )
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Program Wakaf Terbaru', style: CustomFont.blackMedBold),
                      SizedBox(height : 15),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: programs.map((program) =>
                                  ProgramTile(program)).toList())
                      ),
                    ],
                  )
              )


            ],
          ),
        ),

      bottomNavigationBar: BottomNavbar(current: 0),
    );
  }
}
