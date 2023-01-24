import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/mixins/dialog_mixin.dart';
import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/view_models/firebase_service.dart';
import 'package:final_project_mobile/view_models/payment_vm.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/history_tile.dart';
import 'package:final_project_mobile/widgets/notification_tile.dart';
import 'package:final_project_mobile/widgets/reminder_tile.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../styles/color.dart';
import '../../utils/network.dart';
import '../../view_models/auth_vm.dart';
import '../../widgets/loading_screen.dart';
import '../transaction/notification.dart';

class SetReminderPage extends StatefulWidget {
  @override
  _SetReminderPageState createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> with DialogMixin {
  late FirebaseMessaging messaging;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  var scheduled_date;
  var scheduled_amount;
  var scheduled_program;
  PaymentMethod? selectedPaymentMethod;
  var notes;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void dispose() {
    super.dispose();
    dateController.dispose();
    amountController.dispose();
    programController.dispose();
  }

  late TextEditingController dateController;
  late TextEditingController amountController;
  late TextEditingController programController;

  @override
  void initState() {
    dateController = TextEditingController();
    amountController = TextEditingController();
    programController = TextEditingController();

    super.initState();
    context
        .read<PaymentViewModel>()
        .setNetworkService(context.read<BaseNetwork>());
    context
        .read<AuthViewModel>()
        .setNetworkService(context.read<BaseNetwork>());
    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      final PaymentViewModel pvm = context.read<PaymentViewModel>();
      context.read<PaymentViewModel>().fetchAllPaymentMethods().then((value) {
        setState(() {
          selectedPaymentMethod = pvm.all_payment_methods[0];
          dateController.text = pvm.currentReminder!.scheduled_date;
          amountController.text = pvm.currentReminder!.amount;
        });
      });
    });

    messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      showSimpleNotification(
        Text(event.notification!.title!, style: CustomFont.blackMedBold),
        subtitle:
        Text(event.notification!.body!, style: CustomFont.smallTheme),
        background: Colors.white,
        duration: const Duration(seconds: 20),
        elevation: 1,
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Get.to(NotificationPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: SecondAppBar(appBar: AppBar(), title: 'Edit Penjadwalan'),
        body: Consumer<PaymentViewModel>(
            builder: (_, PaymentViewModel vm, __) {
              return SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  spreadRadius: 1.5, //spread radius
                                  blurRadius: 1.5, // blur radius
                                  offset: Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Image.network(IMG_PATH+vm.currentReminder!.program!.cover, fit: BoxFit.cover),
                          ),
                          Expanded(
                              child: Text(vm.currentReminder!.program!.title, style: CustomFont.blackMedBold),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nominal tidak boleh kosong';
                                }
                                scheduled_amount = value;

                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.money),
                                  suffixIcon: InkWell(
                                      child: Icon(Icons.clear, size: 14), onTap: () {
                                    scheduled_amount = '0';
                                  }),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustomColor.themeMuted, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustomColor.themeMuted, width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 2),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 2),
                                  ),
                                  hintText: 'Masukkan jumlah bayar',
                                  label: Text('Jumlah',style: CustomFont.blackMedBold,),
                                  hintStyle: CustomFont.blackMedLight,
                                  isDense: true
                              ),
                              controller: amountController,
                              onChanged: vm.setAmount,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tanggal tidak boleh kosong';
                                }
                                scheduled_date = value;
                                return null;
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_month_outlined),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustomColor.themeMuted, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustomColor.themeMuted, width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 2),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 2),
                                  ),
                                  hintText: 'Masukkan tanggal bayar',
                                  label: Text('Tanggal',style: CustomFont.blackMedBold),
                                  hintStyle: CustomFont.blackMedLight,
                                  isDense: true
                              ),
                              controller: dateController,
                              onChanged: vm.setDate,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateController.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<PaymentMethod>(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_month_outlined),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustomColor.themeMuted, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustomColor.themeMuted, width: 2),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 2),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red, width: 2),
                                  ),
                                  hintText: 'Pilih metode pembayaran',
                                  label: Text('Metode Pembayaran',style: CustomFont.blackMedBold),
                                  hintStyle: CustomFont.blackMedLight,
                                  isDense: true
                              ),
                              value: selectedPaymentMethod,
                              items: vm.all_payment_methods
                                  .map<DropdownMenuItem<PaymentMethod>>(
                                    (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                  alignment: Alignment.center,
                                ),
                              )
                                  .toList(),
                              onChanged: vm.setPaymentMethod,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: CustomButton.buttonSubmit,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (vm.isLoading != true) {
                                    print('submitted!');
                                  } else {
                                    null;
                                  }
                                }
                              },
                              child: Text(
                                  vm.isLoading? 'Memuat...' : 'Simpan',
                                  style : TextStyle(fontSize : 16)),
                            ),

                          ],
                        ),
                      ),
                    ],
                  )

              );
            }
        )
    );
  }
}
