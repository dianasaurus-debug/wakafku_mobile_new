import 'dart:convert';

import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final String title;

  /// you can add more fields that meet your needs

  const AuthAppBar({Key? key, required this.appBar, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: CustomColor.themedarker, size: 25),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title:
        Text('${title}', style: CustomFont.orangeBigBold),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}