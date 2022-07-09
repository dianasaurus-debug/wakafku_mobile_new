import 'dart:convert';

import 'package:final_project_mobile/screens/auth/login.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  /// you can add more fields that meet your needs

  const BaseAppBar({Key? key, required this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_rounded, color: CustomColor.theme),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        elevation: 0,
        actions:  [
          IconButton(
              icon: Icon(CupertinoIcons.arrow_right_square_fill,
                  color: CustomColor.theme),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }),
          // IconButton(
          //   icon: Icon(CupertinoIcons.bell_fill,
          //       color: CustomColor.theme),
          //   onPressed: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) => LoginIndexPage()),
          //     // );
          //   }),
        ]

    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}