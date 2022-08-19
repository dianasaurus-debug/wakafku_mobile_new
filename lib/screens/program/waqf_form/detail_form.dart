import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/screens/program/waqf_form/payment_form.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';


class DetailForm extends StatefulWidget {
  @override
  DetailFormState createState() => new DetailFormState();
}

class DetailFormState extends State<DetailForm> {

  bool isAbadi = false;
  bool isMyself = true;

  @override
  Widget build(BuildContext context){
    return
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
                      // The validator receives the text that the user has entered.
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'E-Mail tidak boleh kosong';
                      //   }
                      //   email = value;
                      //
                      //   return null;
                      // },
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
                        // The validator receives the text that the user has entered.
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'E-Mail tidak boleh kosong';
                        //   }
                        //   email = value;
                        //
                        //   return null;
                        // },
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

                      ),
                      SizedBox(height : 10),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'E-Mail tidak boleh kosong';
                        //   }
                        //   email = value;
                        //
                        //   return null;
                        // },
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

                      ),
                      SizedBox(height : 10),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'E-Mail tidak boleh kosong';
                        //   }
                        //   email = value;
                        //
                        //   return null;
                        // },
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

                      ),
                      SizedBox(height : 10),
                      TextFormField(
                        // The validator receives the text that the user has entered.
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'E-Mail tidak boleh kosong';
                        //   }
                        //   email = value;
                        //
                        //   return null;
                        // },
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
                      // The validator receives the text that the user has entered.
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'E-Mail tidak boleh kosong';
                      //   }
                      //   email = value;
                      //
                      //   return null;
                      // },
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
      );
  }
}
