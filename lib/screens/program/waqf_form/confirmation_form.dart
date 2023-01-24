import 'package:final_project_mobile/models/payment_instruction.dart';
import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/home/beranda.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/screens/program/waqf_form/payment_instruction.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/view_models/program_vm.dart';
import 'package:final_project_mobile/widgets/accordion.dart';
import 'package:final_project_mobile/widgets/payment_tile.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/network.dart';
import '../../../view_models/firebase_service.dart';

class ConfirmationForm extends StatefulWidget {
  @override
  ConfirmationFormState createState() => new ConfirmationFormState();
}

class ConfirmationFormState extends State<ConfirmationForm> {
  void viewModel() {
    context
        .read<ProgramViewModel>()
        .setNetworkService(context.read<BaseNetwork>());
    context.read<ProgramViewModel>().fetchAllPrograms();
  }

  @override
  void initState() {
    viewModel();
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      context
          .read<ProgramViewModel>()
          .setNetworkService(context.read<BaseNetwork>());
      final ProgramViewModel svm = context.read<ProgramViewModel>();
    });
    FirebaseService.inAppFirebaseNotif();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramViewModel>(
        builder: (_, ProgramViewModel program_vm, __) => Scaffold(
              backgroundColor: CustomColor.whitebg,
              body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Center(
                      child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle,
                                  size: 70, color: CustomColor.themedarker),
                              SizedBox(height: 10),
                              Text(
                                  'Selamat, Transaksi wakaf uang berhasil dibuat!',
                                  style: CustomFont.darkerBigBold),
                              SizedBox(height: 20),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                  'Selesaikan Pembayaran Sebelum',
                                                  style:
                                                      CustomFont.blackMedLight),
                                              SizedBox(height: 10),
                                              Text('24 jam 21 menit 19 detik',
                                                  style:
                                                      CustomFont.orangeBigBold),
                                            ],
                                          )),
                                      Divider(
                                        color: Color(0xff80cbc4),
                                      ),
                                      SizedBox(height: 5),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Nama Program',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            SizedBox(height: 5),
                                            Text(
                                                '${program_vm.currentProgram!.title}',
                                                style: CustomFont.blackMedBold),
                                          ]),
                                      SizedBox(height: 8),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Jenis Wakaf Uang',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            SizedBox(height: 5),
                                            Text(
                                                program_vm.currentTransaction!
                                                            .jenisWakaf ==
                                                        'abadi'
                                                    ? 'Wakaf Abadi'
                                                    : 'Wakaf Berjangka',
                                                style: CustomFont.blackMedBold),
                                          ]),
                                      SizedBox(height: 8),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Informasi Pembayaran',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            SizedBox(height: 5),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 3,
                                                    blurRadius: 3,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            'Nominal Pembayaran',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                        SizedBox(height: 5),
                                                        Text(
                                                            formatCurrency.format(
                                                                int.parse(program_vm
                                                                        .currentTransaction!
                                                                        .amount ??
                                                                    "Loading...")),
                                                            style: CustomFont
                                                                .blackMedBold),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            if (program_vm.currentTransaction!.paymentMethod!.kind !=
                                                                'ewallet') ...[
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'Kode Pembayaran',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey)),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                        program_vm.currentTransaction!.paymentCode ??
                                                                            "Loading...",
                                                                        style: CustomFont
                                                                            .blackMedBold),
                                                                  ])
                                                            ],
                                                            IconButton(
                                                                onPressed:
                                                                    () {},
                                                                icon: Icon(
                                                                    FontAwesomeIcons
                                                                        .copy))
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                            'Metode Pembayaran',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                        SizedBox(height: 5),
                                                        Row(children: [
                                                          Image.network(
                                                              BANK_LOGO_IMG_PATH +
                                                                  program_vm
                                                                      .currentTransaction!
                                                                      .paymentMethod!
                                                                      .logo,
                                                              width: 50),
                                                          SizedBox(width: 5),
                                                          Text(
                                                              '${program_vm.currentTransaction!.paymentMethod!.name}',
                                                              style: CustomFont
                                                                  .blackMedBold),
                                                        ])
                                                      ]),
                                                  SizedBox(height: 5),
                                                  Divider(
                                                    color: Color(0xff80cbc4),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                      SizedBox(height: 10),
                                    ],
                                  )),
                              TextButton(
                                child: Text('Panduan Pembayaran',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: CustomColor.themedarker,
                                        fontSize: 16)),
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                      builder: (context) =>
                                          InstruksiPembayaran());
                                  Navigator.push(context, route);
                                },
                              )
                            ],
                          )))),
              floatingActionButton: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              child: Text("Kembali ke Beranda",
                                  style: CustomFont.whiteBigBold),
                              style: CustomButton.buttonSubmit,
                              onPressed: () {
                                Route route = MaterialPageRoute(
                                    builder: (context) => HomePage());
                                Navigator.push(context, route);
                              }))
                    ],
                  )),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ));
  }
}
