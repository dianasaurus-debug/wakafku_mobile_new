import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/screens/program/waqf_form/detail_form.dart';
import 'package:final_project_mobile/screens/program/waqf_form/form.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/constants.dart';

class ProgramReport extends StatefulWidget {
  @override
  _ProgramReportState createState() => _ProgramReportState();
}

class _ProgramReportState extends State<ProgramReport> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: CustomColor.themedarker, size: 25),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
              ])),
      floatingActionButton: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: ElevatedButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Berwakaf", style: CustomFont.whiteBigBold),
                            ]),
                        style: CustomButton.buttonSubmit,
                        onPressed: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => DetailForm());
                          Navigator.push(context, route);
                        })),
                SizedBox(width: 10),
                Expanded(
                    child: ElevatedButton(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Navigasi", style: CustomFont.whiteBigBold),
                            ]),
                        style: CustomButton.buttonSubmit,
                        onPressed: () => {}))
              ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
