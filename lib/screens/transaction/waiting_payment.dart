
import 'dart:async';

import 'package:final_project_mobile/screens/home/beranda.dart';
import 'package:final_project_mobile/screens/transaction/history.dart';
import 'package:final_project_mobile/screens/transaction/notification.dart';
import 'package:final_project_mobile/view_models/firebase_service.dart';
import 'package:final_project_mobile/view_models/payment_vm.dart';
import 'package:final_project_mobile/view_models/program_vm.dart';
import 'package:final_project_mobile/widgets/loading_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../styles/button.dart';
import '../../styles/color.dart';
import '../../styles/font.dart';
import '../../utils/network.dart';

class LoadingRedirect extends StatefulWidget {
  const LoadingRedirect({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoadingRedirectState();
}

class LoadingRedirectState extends State<LoadingRedirect> with WidgetsBindingObserver {
  late FirebaseMessaging messaging;

  var parameter = Get.arguments;
  Timer? _timerLink;
  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _timerLink = Timer(
        const Duration(milliseconds: 1000),
            () {
              FirebaseService.initDynamicLink(context);
        },
      );
    }
  }

  Timer? countdownTimer;
  Duration? myDuration;


  @override
  void initState() {
    super.initState();
    startTimer();
    WidgetsBinding.instance.addObserver(this);
    context
        .read<PaymentViewModel>()
        .setNetworkService(context.read<BaseNetwork>());
    context
        .read<ProgramViewModel>()
        .setNetworkService(context.read<BaseNetwork>());
    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      final ProgramViewModel pvm = context.read<ProgramViewModel>();
      final PaymentViewModel payment_vm = context.read<PaymentViewModel>();
      pvm.currentTransaction = payment_vm.currentTransaction;
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
    context.read<PaymentViewModel>().fetchPaymentDetail(parameter[0]);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Menunggu Pembayaran',
              style: CustomFont.blackMedBold),
          centerTitle: false,
          backgroundColor: CustomColor.whitebg,
          automaticallyImplyLeading: false,
        ),
        body: WillPopScope(
            onWillPop: () { // this is the block you need
              Get.off(HomePage());
              return Future.value(false);
            }, child:
        Consumer<PaymentViewModel>(
          builder: (_, PaymentViewModel vm, __) {
            if (vm.isLoading) {
              return LoadingScreen();
            } else {
              return SafeArea(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 50),
                            if(vm.currentTransaction?.paymentMethod!.label == 'ID_OVO')...[
                              if(_start == 0)...[
                                Text('Waktu pembayaran sudah habis',
                                    style: CustomFont.blackMedBold,
                                    textAlign: TextAlign.center),
                                ElevatedButton(
                                  style: CustomButton.buttonSubmit,
                                  onPressed: (){
                                    Route route = MaterialPageRoute(builder: (context) => HistoryPage());
                                    Navigator.push(context, route);
                                  },
                                  child: Text('Daftar Pembayaran', style: CustomFont.whiteMedBold,),
                                ),


                              ] else
                                ...[
                                  Text(
                                      'Bayar dalam  ${_start} Detik...\nAkan terdapat notifikasi di aplikasi OVO Anda, klik untuk membayar',
                                      style: CustomFont.blackMedBold,
                                      textAlign: TextAlign.center)
                                ]
                            ] else
                              ...[
                                Text(
                                    'Mengalihkan Kamu ke halaman ${vm.currentTransaction!.paymentMethod!.name} dalam beberapa saat...',
                                    style: CustomFont.blackMedBold,
                                    textAlign: TextAlign.center)
                              ]

                          ]
                      ),
                    ),

                  ],
                ),
              );
            }
          }

        ))
    );
  }
}
