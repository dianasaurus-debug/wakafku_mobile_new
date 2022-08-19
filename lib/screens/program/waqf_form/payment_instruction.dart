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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';



class InstruksiPembayaran extends StatefulWidget {
  // final PaymentMethod? payment_method;
  //
  //
  // const InstruksiPembayaran({Key? key, required this.payment_method}) : super(key: key);
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
                        appBar: AppBar(
                          elevation: 0,
                          backgroundColor: CustomColor.whitebg,
                          automaticallyImplyLeading: false,
                          actions: [
                            IconButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                icon : Icon(FontAwesomeIcons.times, color: CustomColor.themedarker)
                            )
                          ],
                        ),
                        body: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child : ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: payment_instructions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Accordion(
                                  Text(
                                      '${payment_instructions[index].title}',
                                      style: CustomFont.blackMedBold),
                                  Text('${payment_instructions[index].desc}')
                                // Text('${order_vm.instruction_list[index].desc}')
                              );
                            },
                            separatorBuilder: (context, position) {
                              return Divider(
                                color: CustomColor.mutedText,
                              );
                            },
                          )),
                      );
  }
}
