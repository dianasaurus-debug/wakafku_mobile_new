import 'package:badges/badges.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/models/transaction.dart';
import 'package:final_project_mobile/screens/transaction/detail.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile(this.transaction);

  @required
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: (){
      Route route = MaterialPageRoute(builder: (context) => TransactionDetail(transaction : this.transaction));
      Navigator.push(context, route);
    }, child: Container(
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
                Text('${convertToDate(transaction.createdAt)}', style: CustomFont.blackSmallight),
                Text('${convertToTime(transaction.createdAt)}', style: CustomFont.blackSmallight)
              ],
            ),
                Divider(
                  color: CustomColor.themeGrey,
                ),
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage('https://paybill.id/cfd/upload/banner-program/compress/paybill-program-banner-1-EBVRED-1619193991599.png',
                        )),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rp ${transaction.amount}', style: CustomFont.blackMedBold),
                          Text('${transaction.program!.title}', style: CustomFont.blackSmallight),
                          SizedBox(height : 5),
                          Badge(
                            toAnimate: false,
                            shape: BadgeShape.square,
                            badgeColor: PAYMENT_STATUS_COLOR[int.parse(transaction.status!)],
                            borderRadius: BorderRadius.circular(8),
                            badgeContent: Text(PAYMENT_STATUS[int.parse(transaction.status!)], style: CustomFont.whiteSmallBold),
                          )
                        ],
                      )
                    )
                  ],
                ),

          ]),
          // trailing: Text('6 Km',
          //     style: CustomFont.orangeMedBold),
        )
    ));
  }
}
