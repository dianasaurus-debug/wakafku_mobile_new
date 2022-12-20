import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/screens/program/waqf_form/payment_form.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/network.dart';
import 'package:final_project_mobile/view_models/program_vm.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DetailForm extends StatefulWidget {
  @override
  DetailFormState createState() => new DetailFormState();
}

class DetailFormState extends State<DetailForm> {

  bool isAbadi = false;
  bool isMyself = true;
  late TextEditingController nominalController;
  late TextEditingController jangkaWaktuController;
  late TextEditingController bankController;
  late TextEditingController nomorRekeningController;
  late TextEditingController pemilikRekeningController;
  late TextEditingController atasNamaController;

  void viewModel() {
    context
        .read<ProgramViewModel>().setNetworkService(context.read<BaseNetwork>());
    context.read<ProgramViewModel>().fetchAllPrograms();
  }

  @override
  void initState() {
    viewModel();
    super.initState();
    nominalController = TextEditingController();
    jangkaWaktuController = TextEditingController();
    bankController = TextEditingController();
    nomorRekeningController = TextEditingController();
    pemilikRekeningController = TextEditingController();
    atasNamaController = TextEditingController();
    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      context
          .read<ProgramViewModel>()
          .setNetworkService(context.read<BaseNetwork>());
      final ProgramViewModel svm = context.read<ProgramViewModel>();
      // messaging.getToken().then((value) {
      //   svm.setFCMToken(value);
      // });
     
    });
  }
  @override
  Widget build(BuildContext context){
    return
      Consumer<ProgramViewModel>(
          builder: (_, ProgramViewModel program_vm, __) =>
      Scaffold(
        backgroundColor: Colors.white,
        appBar: SecondAppBar(appBar: AppBar(), title : 'Detail'),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom : 10),
                  child : Align(
                    alignment: Alignment.center,
                    child : Text('Detail Wakaf Uang', style: CustomFont.blackBigBold),
                  )
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical : 10),
                  child :  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children : [
                        Text('Nominal Wakaf Uang', style: CustomFont.blackMedBold),
                        SizedBox(height : 5),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nominal tidak boleh kosong';
                            }
                            program_vm.amount = int.parse(value);

                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.rupiahSign),
                              suffixIcon: InkWell(
                                  child: Icon(Icons.clear, size: 14), onTap: () {
                                // email = '';
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
                              hintText: 'Masukkan Nominal',
                              hintStyle: CustomFont.blackMedLight,
                              isDense: true
                          ),
                          controller : nominalController,
                          onChanged: program_vm.onAmountChange,

                        ),
                      ])
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical : 10),
                  child :  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children : [
                        Text('Jenis Wakaf Uang', style: CustomFont.blackMedBold),
                        SizedBox(height : 5),
                        Row(
                            children:[
                              ChoiceChip(
                                  label: Text('Wakaf Abadi', style: CustomFont.whiteMedBold),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 10),
                                  selected: isAbadi== true,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      isAbadi= selected ? true : false;
                                      if(selected==true){
                                        program_vm.onJenisWakafChange('abadi');
                                      }
                                    });
                                  },
                                  selectedColor: CustomColor.theme,
                                  shape: ContinuousRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15.0))),
                              SizedBox(width: 10),
                              ChoiceChip(
                                  label: Text('Wakaf Berjangka', style: CustomFont.whiteMedBold),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 10),
                                  selected: isAbadi== false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      isAbadi= selected == false ? true : false;
                                      if(selected==true){
                                        program_vm.onJenisWakafChange('berjangka');

                                      }
                                    });
                                  },
                                  selectedColor: CustomColor.theme,
                                  shape: ContinuousRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15.0)))
                            ]
                        ),
                        if(isAbadi==false)...[
                          Text('Detail Pengembalian', style: CustomFont.blackMedBold),
                          SizedBox(height : 15),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'E-Mail tidak boleh kosong';
                              }
                              program_vm.jangka_waktu = int.parse(value);
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    child: Icon(Icons.clear, size: 14), onTap: () {
                                  // email = '';
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
                                label: Text('Jangka Waktu', style: CustomFont.blackMedLight),
                                isDense: true
                            ),
                            onChanged: program_vm.onJangkaWaktu,
                            controller: jangkaWaktuController,
                          ),
                          SizedBox(height : 10),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'E-Mail tidak boleh kosong';
                              }
                              program_vm.bankPengembalian = value;

                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    child: Icon(Icons.clear, size: 14), onTap: () {
                                  // email = '';
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
                                label: Text('Bank Pengembalian', style: CustomFont.blackMedLight),
                                isDense: true
                            ),
                            onChanged: program_vm.onBankPengembalianChange,
                            controller: bankController,
                          ),
                          SizedBox(height : 10),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nomor rekening tidak boleh kosong';
                              }
                              program_vm.nomorRekening = value;

                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    child: Icon(Icons.clear, size: 14), onTap: () {
                                  // email = '';
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
                                label: Text('Nomor Rekening', style: CustomFont.blackMedLight),

                                isDense: true
                            ),
                            onChanged: program_vm.onNorekChange,
                            controller: nomorRekeningController,
                          ),
                          SizedBox(height : 10),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama pemiliki rekening tidak boleh kosong';
                              }
                              program_vm.namaPemilikRekening = value;

                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    child: Icon(Icons.clear, size: 14), onTap: () {
                                  // email = '';
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
                                label: Text('Nama Pemilik Rekening', style: CustomFont.blackMedLight),
                                isDense: true
                            ),
                            onChanged: program_vm.onNamaRekeningChange,
                            controller: pemilikRekeningController,
                          ),
                        ],


                      ])
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical : 10),
                  child :  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children : [
                        Text('Atas Nama', style: CustomFont.blackMedBold),
                        SizedBox(height : 5),
                        Row(
                            children:[
                              ChoiceChip(
                                  label: Text('Saya Sendiri', style: CustomFont.whiteMedBold),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 10),
                                  selected: isMyself== true,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      isMyself= selected ? true : false;
                                    });
                                  },
                                  selectedColor: CustomColor.theme,
                                  shape: ContinuousRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15.0))),
                              SizedBox(width: 10),
                              ChoiceChip(
                                  label: Text('Orang Lain', style: CustomFont.whiteMedBold),
                                  labelPadding: EdgeInsets.symmetric(horizontal: 10),
                                  selected: isMyself== false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      isMyself= selected == false ? true : false;
                                    });
                                  },
                                  selectedColor: CustomColor.theme,
                                  shape: ContinuousRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15.0)))
                            ]
                        ),
                        SizedBox(height : 5),
                        isMyself==false?
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'E-Mail tidak boleh kosong';
                            }
                            program_vm.atas_nama = value;

                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  child: Icon(Icons.clear, size: 14), onTap: () {
                                // email = '';
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
                              hintText: 'Nama Wakif',
                              hintStyle: CustomFont.blackMedLight,
                              isDense: true
                          ),
                          controller: atasNamaController,
                          onChanged : program_vm.onAtasNamaChange

                        ) : Container(),
                      ])
              )
            ],
          ),
        ),
        floatingActionButton: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child : Row(
              children: [
                Expanded(
                    child : ElevatedButton(
                        child: Text("Lanjutkan ke Pembayaran",
                            style:
                            CustomFont.whiteBigBold),
                        style: CustomButton.buttonSubmit,
                        onPressed: () {
                          Route route = MaterialPageRoute(builder: (context) => PaymentForm());
                          Navigator.push(context, route);
                        })
                )
              ],
            )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ));
  }
}
