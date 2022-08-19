import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/controllers/vendor.dart';
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
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/constants.dart';

class Coba extends StatefulWidget {
  @override
  _CobaState createState() => _CobaState();
}

class _CobaState extends State<Coba> {

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
          actions: [
            GestureDetector(
              child: Icon(Icons.bookmark,
                  color: CustomColor.themedarker, size: 25),
              onTap: () => Navigator.of(context).pop(),
            ),
            IconButton(
              icon: Icon(Icons.share, color: CustomColor.themedarker, size: 25),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          elevation: 0),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'What is on your mind?'),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await VendorNetwork().getCariItem(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    var suggestion_parse = (suggestion as Map);
                    return ListTile(
                      title: Text(suggestion_parse['itemcode']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    var detail_suggestion_parse = (suggestion as Map);
                    print(detail_suggestion_parse);
                  },
                ),
              ])),
    );
  }
}
