import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SecondAppBar(appBar: AppBar(), title : 'Histori'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(child : Text('Hi, this is histori!'))
        ],
      ),
      bottomNavigationBar: BottomNavbar(current: 2),
    );
  }
}
