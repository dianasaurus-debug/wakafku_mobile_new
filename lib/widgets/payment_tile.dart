import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/screens/program/waqf_form/payment_instruction.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile(this.payment_method, );

  @required
  final PaymentMethod payment_method;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return
      GestureDetector(
          onTap: (){
            Route route = MaterialPageRoute(builder: (context) => InstruksiPembayaran(payment_method: payment_method));
            Navigator.push(context, route);
          },
          child : Container(
            child: ListTile(
              title: Text(
                  payment_method.name,
                  style: CustomFont.blackMedBold
              ),
              leading: AspectRatio(
                aspectRatio: 3.0 / 5.0,
                child: Image.asset(payment_method.logo),
              ),
              trailing: IconButton(
                icon : Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () {
                  //
                },
              ),
            ),
          )
      );

  }

}
