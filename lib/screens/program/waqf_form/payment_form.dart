import 'package:final_project_mobile/models/payment_method.dart';
import 'package:final_project_mobile/models/program.dart';
import 'package:final_project_mobile/screens/program/detail.dart';
import 'package:final_project_mobile/screens/program/waqf_form/confirmation_form.dart';
import 'package:final_project_mobile/screens/program/waqf_form/detail_form.dart';
import 'package:final_project_mobile/styles/button.dart';
import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/widgets/accordion.dart';
import 'package:final_project_mobile/widgets/payment_tile.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/mixins/dialog_mixin.dart';
import '../../../utils/network.dart';
import '../../../view_models/auth_vm.dart';
import '../../../view_models/program_vm.dart';


class PaymentForm extends StatefulWidget {
  @override
  PaymentFormState createState() => new PaymentFormState();
}

class PaymentFormState extends State<PaymentForm> with DialogMixin {

  bool isAbadi = false;
  bool isMyself = true;
  int selected = -1;
  void viewModel() {
    context
        .read<ProgramViewModel>().setNetworkService(context.read<BaseNetwork>());
  }

  @override
  void initState() {
    viewModel();
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      context
          .read<ProgramViewModel>()
          .setNetworkService(context.read<BaseNetwork>());
      context
          .read<AuthViewModel>()
          .setNetworkService(context.read<BaseNetwork>());
      final ProgramViewModel svm = context.read<ProgramViewModel>();

      context.read<AuthViewModel>().fetchUser();
      context.read<ProgramViewModel>().fetchAllBanks();

      // messaging.getToken().then((value) {
      //   svm.setFCMToken(value);
      // });

    });
  }
  Widget _paymentTile(int index, PaymentMethod items, ProgramViewModel program_vm) {
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
            if (expanded){
              setState(() {
                Duration(seconds: 20000);
                selected = index;
              });
              print(payment_methods[index].label);
              program_vm.onPaymentMethodChange(items.label);
            }

            else
              setState(() {
                selected = -1;
              });
          },
          title: Row(children: [
            Image.network(BANK_LOGO_IMG_PATH+items.logo, width : 50),
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
      Consumer<ProgramViewModel>(
          builder: (_, ProgramViewModel program_vm, __) =>
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
                      itemCount: program_vm.all_bank.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _paymentTile(index, program_vm.all_bank[index], program_vm);
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
                    child: Text(program_vm.isLoading == true ? 'Memuat...' : "Bayar",
                        style:
                        CustomFont.whiteBigBold),
                    style: CustomButton.buttonSubmit,
                    onPressed: () {
                      if(program_vm.payment_method!=null){
                        program_vm.createTransaction().then((value) {
                          if(program_vm.isSuccess==true){
                            showSuccessSnackbar('Membuat data pembayaran berhasil!');
                            Get.offAll(ConfirmationForm());
                          } else {
                            showSingleActionDialog(
                              'Oops!',
                              'Pembayaran gagal!',
                              'Coba lagi',
                                  () => Get.offAll(DetailForm()),
                            );
                          }
                        });
                        // Route route = MaterialPageRoute(builder: (context) => ConfirmationForm());
                        // Navigator.push(context, route);
                      } else {
                        showSingleWarningDialog('Mohon pilih metode pembayaran dulu');
                      }

                    })
              )
            ],
          )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ));

  }
}
