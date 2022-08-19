import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/screens/program/waqf_form/confirmation_form.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/widgets/accordion.dart';
import 'package:final_project_mobile/widgets/payment_tile.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
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
  int selected = -1;

  Widget _paymentTile(int index, PaymentMethod items) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child : ExpansionTile(
          key: Key(index.toString()),
          //attention
          initiallyExpanded: index == selected,
          //attention
          trailing: Icon(
            index == selected ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          onExpansionChanged: (expanded) {
            if (expanded)
              setState(() {
                Duration(seconds: 20000);
                selected = index;
              });
            else
              setState(() {
                selected = -1;
              });
          },
          title: Row(children: [
            Image.asset(items.logo, width : 50),
            SizedBox(width : 10),
            Expanded(
                child : Text(items.name, style: CustomFont.blackBigBold)
            )

          ]),
          children: <Widget>[
            ListTile(
              title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(payment_instructions[0].title+'\n'+payment_instructions[0].desc+'\n\n'+payment_instructions[1].title+'\n'+payment_instructions[1].desc)
              ]),
            )
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return
      Scaffold(
          backgroundColor: CustomColor.whitebg,
          appBar: SecondAppBar(appBar: AppBar(), title : 'Pembayaran'),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children : [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child : Align(
                        alignment: Alignment.center,
                        child : Text('Pilih Metode Pembayaran', style: CustomFont.blackBigBold),
                      )
                  ),
                  ListView.builder(
                      key: Key(
                          'builder ${selected.toString()}'),
                      //attention
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: payment_methods.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _paymentTile(index, payment_methods[index]);
                      },
                    ),
                ]
            ),
          ),
        floatingActionButton: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child : Row(
            children: [
              Expanded(
                child : ElevatedButton(
                    child: Text("Bayar",
                        style:
                        CustomFont.whiteBigBold),
                    style: CustomButton.buttonSubmit,
                    onPressed: () {
                      Route route = MaterialPageRoute(builder: (context) => ConfirmationForm());
                      Navigator.push(context, route);
                    })
              )
            ],
          )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  }
}
