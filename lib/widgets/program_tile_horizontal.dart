import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ProgramTileHorizontal extends StatelessWidget {
  const ProgramTileHorizontal(this.program);

  @required
  final Program program;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          //border corner radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 3, //spread radius
              blurRadius: 3, // blur radius
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
      child : ListTile(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  //border corner radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), //color of shadow
                      spreadRadius: 3, //spread radius
                      blurRadius: 3, // blur radius
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Image.network(IMG_PATH+program.cover, fit: BoxFit.cover),
              ),
              Expanded(
                  child: Column(
                    children: [
                      Text(program.title, style: CustomFont.blackMedBold),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children : [
                            Icon(FontAwesomeIcons.locationPin,
                                color:CustomColor.theme, size: 20),
                            SizedBox(width : 5),
                            Expanded(
                              child : Text(
                                program.address_detail,
                                style: CustomFont.blackTinyLight,
                              ),
                            )
                          ]
                      ),
                      Row(children: [
                        Icon(FontAwesomeIcons.arrowRight,
                            color: CustomColor.theme, size: 20),
                        SizedBox(width: 5),
                        Text(
                          '${program.distance.toStringAsFixed(1)} Km',
                          style: CustomFont.blackSmallight,
                        ),
                      ]),
                    ],
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){

                  },
                  child :Text(
                    'Rute terdekat',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: CustomColor.themedarker,
                      fontSize: 13
                    ),
                  )
              ),
              ElevatedButton(
                style: CustomButton.buttonSubmit,
                child: const Text('Detail'),
                onPressed: () {
                  Route route = MaterialPageRoute(builder: (context) => ProgramDetail(program : program));
                  Navigator.push(context, route);
                },
              ),
            ],
          )
        ]),
        // trailing: Text('6 Km',
        //     style: CustomFont.orangeMedBold),
      )
    );
  }
}
