import 'package:badges/badges.dart';
import 'package:final_project_mobile/models/notification.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/models/transaction.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile(this.notification);

  @required
  final NotificationModel notification;

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
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${convertToDate(notification.createdAt)}', style: CustomFont.blackSmallight),
                    Text('${convertToTime(notification.createdAt)}', style: CustomFont.blackSmallight)
                  ],
                ),
                Divider(
                  color: CustomColor.themeGrey,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${notification.title}', style: CustomFont.blackMedBold),
                    Text('${notification.content}', style: CustomFont.blackSmallight),
                  ],
                )

              ]),
          // trailing: Text('6 Km',
          //     style: CustomFont.orangeMedBold),
        )
    );
  }
}
