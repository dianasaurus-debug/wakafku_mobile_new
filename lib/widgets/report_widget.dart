import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/models/report.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ReportTile extends StatelessWidget {
  const ReportTile(this.report);

  @required
  final Report report;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        margin: EdgeInsets.only(right: 10, bottom: 10),
        child : Container(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.title,
                          style: CustomFont.orangeMedBold,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          convertToDateTime(report.created_at),
                          style: CustomFont.blackMedLight,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Html(data: """${report.desc}"""),

                      ])),

            ],
          ),
        )
    );
  }
}
