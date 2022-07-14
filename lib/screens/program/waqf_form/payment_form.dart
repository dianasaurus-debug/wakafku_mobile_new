import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/widgets/accordion.dart';
import 'package:final_project_mobile/widgets/payment_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';


class PaymentForm extends StatefulWidget {
  @override
  PaymentFormState createState() => new PaymentFormState();
}

class PaymentFormState extends State<PaymentForm> {

  bool isAbadi = false;
  bool isMyself = true;

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children : [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child : Align(
                alignment: Alignment.center,
                child : Text('Pilih Metode Pembayaran', style: CustomFont.blackBigBold),
              )
          ),
          Accordion(
              Text('Virtual Account', style: CustomFont.blackMedBold,),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: payment_methods.length,
                itemBuilder: (BuildContext context, int index) {
                  return PaymentTile(payment_methods[index]);
                },
                separatorBuilder: (context, position) {
                  return Divider(
                    color: CustomColor.mutedText,
                  );
                },
              )
            // Text('${order_vm.instruction_list[index].desc}')
          ),
          Accordion(
              Text('E-Wallet', style: CustomFont.blackMedBold,),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: payment_methods.length,
                itemBuilder: (BuildContext context, int index) {
                  return PaymentTile(payment_methods[index]);
                },
                separatorBuilder: (context, position) {
                  return Divider(
                    color: CustomColor.mutedText,
                  );
                },
              )
            // Text('${order_vm.instruction_list[index].desc}')
          ),
          Accordion(
              Text('Minimarket', style: CustomFont.blackMedBold,),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: payment_methods.length,
                itemBuilder: (BuildContext context, int index) {
                  return PaymentTile(payment_methods[index]);
                },
                separatorBuilder: (context, position) {
                  return Divider(
                    color: CustomColor.mutedText,
                  );
                },
              )
            // Text('${order_vm.instruction_list[index].desc}')
          ),
          Accordion(
              Text('QR Code', style: CustomFont.blackMedBold,),
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: payment_methods.length,
                itemBuilder: (BuildContext context, int index) {
                  return PaymentTile(payment_methods[index]);
                },
                separatorBuilder: (context, position) {
                  return Divider(
                    color: CustomColor.mutedText,
                  );
                },
              )
            // Text('${order_vm.instruction_list[index].desc}')
          ),

        ]
      ),
    );
  }
}
