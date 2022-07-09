import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/material.dart';

class ProgramDetail extends StatefulWidget {
  @override
  _ProgramDetailState createState() => _ProgramDetailState();
}

class _ProgramDetailState extends State<ProgramDetail> {

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
          icon: Icon(Icons.arrow_back_ios_rounded, color: CustomColor.themedarker, size: 25),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          GestureDetector(
            child: Icon(Icons.bookmark, color: CustomColor.themedarker, size: 25),
            onTap: () => Navigator.of(context).pop(),
          ),
          IconButton(
            icon: Icon(Icons.share, color: CustomColor.themedarker, size: 25),
            onPressed : () => Navigator.of(context).pop(),
          ),
        ],
        elevation: 0
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child : Text('hola! this is detail')
      ),
      bottomNavigationBar: BottomNavbar(current: 3),
    );
  }
}
