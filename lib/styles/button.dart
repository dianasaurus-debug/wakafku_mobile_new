import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/material.dart';

class CustomButton {
  static final ButtonStyle buttonSocial = ElevatedButton.styleFrom(
    textStyle: CustomFont.orangeMedBold,
    onPrimary: Colors.white70,
    primary: CustomColor.whitebg,
    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      side: BorderSide(color: CustomColor.theme),
    ),
  );
  static final ButtonStyle buttonSubmit = ElevatedButton.styleFrom(
    textStyle: CustomFont.whiteMedBold,
    onPrimary: Colors.white,
    primary: CustomColor.theme,
    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    
  );
}
