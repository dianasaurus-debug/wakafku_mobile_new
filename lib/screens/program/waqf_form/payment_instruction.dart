import 'dart:async';

import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/screens/program/waqf_form/form.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/widgets/accordion.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';



class InstruksiPembayaran extends StatefulWidget {
  final PaymentMethod? payment_method;


  const InstruksiPembayaran({Key? key, required this.payment_method}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new InstruksiPembayaranState();
}

class InstruksiPembayaranState extends State<InstruksiPembayaran> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: CustomColor.whitebg,
                        appBar: SecondAppBar(appBar: AppBar(), title : 'Instruksi Pembayaran'),
                        body: SingleChildScrollView(child : Column(
                          children: [
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(color: CustomColor.whitebg),
                                child : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
                                        child : Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children : [
                                              Container(
                                                  width : size.width/2,
                                                  child : Text('Transfer Bank ${widget.payment_method!.name}', style: CustomFont.blackBigBold,)
                                              ),
                                              Image.asset(widget.payment_method!.logo, width: 120),
                                            ]
                                        )
                                    ),
                                    Divider(color : CustomColor.mutedButton),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child : Text('Cara Pembayaran', style: CustomFont.blackMedBold,)
                                    ),
                                    ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: payment_instructions.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Accordion(
                                            RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: 'Panduan Pembayaran melalui ',
                                                    style: CustomFont.blackMedLight),
                                                TextSpan(
                                                    text: '${payment_instructions[index].title}',
                                                    style: CustomFont.blackMedBold),
                                              ]),
                                            ),
                                           Text('${payment_instructions[index].desc}')
                                          // Text('${order_vm.instruction_list[index].desc}')
                                        );
                                      },
                                      separatorBuilder: (context, position) {
                                        return Divider(
                                          color: CustomColor.mutedText,
                                        );
                                      },
                                    )
                                  ],
                                )
                            ),
                          ],
                        )),
                        floatingActionButton: Padding(
                            padding : EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child : ElevatedButton(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Bayar",
                                          style: CustomFont.whiteBigLight),
                                    ]),
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(
                                        CustomColor.theme),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        CustomColor.theme),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            side:
                                            BorderSide(color: CustomColor.theme)))),
                                onPressed: () {
                                  Route route = MaterialPageRoute(builder: (context) => IndexForm(currentStep: 2));
                                  Navigator.push(context, route);
                                })
                        ),
                        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                      );
  }
}
