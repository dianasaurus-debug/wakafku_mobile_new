import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ProgramTile extends StatelessWidget {
  const ProgramTile(this.program);

  @required
  final Program program;

  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
      onTap: (){
        Route route = MaterialPageRoute(builder: (context) => ProgramDetail(program : this.program));
        Navigator.push(context, route);
      },
      child : Card(
          elevation: 3,
          margin: EdgeInsets.only(right: 10),
          child : Container(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  width: 250,
                  child : Container(
                    child: Image.network(IMG_PATH+program.cover, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            program.title,
                            style: CustomFont.orangeMedBold,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                              children : [
                                Icon(FontAwesomeIcons.locationPin,
                                    color:CustomColor.theme, size: 20),
                                SizedBox(width : 5),
                                Text(
                                  program.address_detail,
                                  style: CustomFont.blackSmallight,
                                ),
                              ]
                          ),
                          Row(
                              children : [
                                Icon(FontAwesomeIcons.arrowRight,
                                    color:CustomColor.theme, size : 20),
                                SizedBox(width : 5),
                                Text(
                                  '${program.distance.toStringAsFixed(1)} Km',
                                  style: CustomFont.blackSmallight,
                                ),
                              ]
                          ),
                          SizedBox(
                            height: 8,
                          ),

                        ])),
              ],
            ),
          )
      )
    );
  }
}
