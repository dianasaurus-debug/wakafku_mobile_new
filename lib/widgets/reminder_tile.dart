import 'package:badges/badges.dart';
import 'package:final_project_mobile/models/notification.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/models/schedule.dart';
import 'package:final_project_mobile/models/transaction.dart';
import 'package:final_project_mobile/screens/profile/set_schedule.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/view_models/payment_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../screens/transaction/detail.dart';
import '../utils/constants.dart';

class ReminderTile extends StatelessWidget {
  const ReminderTile(this.reminder, this.payment_vm);

  @required
  final Schedule reminder;
  final PaymentViewModel payment_vm;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        payment_vm.setReminder(this.reminder);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SetReminderPage()),
        );
      },
      child : Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

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
                      Text('${convertToDate(reminder.scheduled_date)}', style: CustomFont.blackMedBold),
                      Text('Rp ${reminder.amount}', style: CustomFont.blackMedBold),
                    ],
                  ),
                  SizedBox(height : 10),
                  Text('${reminder!.program!.title}', style: CustomFont.blackMedLight),
                  if(reminder!.transaction!=null)...[
                    SizedBox(height : 10),
                    ElevatedButton(
                      style: CustomButton.buttonSubmit,
                      onPressed: () {
                        Route route = MaterialPageRoute(builder: (context) => TransactionDetail(transaction : this.reminder!.transaction!));
                        Navigator.push(context, route);
                      },
                      child: Text(
                          'Bayar',
                          style : TextStyle(fontSize : 16)),
                    ),
                  ]
                ]),
            // trailing: Text('6 Km',
            //     style: CustomFont.orangeMedBold),
          )
      )
    );
  }
}
