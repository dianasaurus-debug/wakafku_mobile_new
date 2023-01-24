import 'dart:async';
import 'dart:ui';

import 'package:final_project_mobile/mixins/dialog_mixin.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:final_project_mobile/utils/constants.dart';
import 'package:final_project_mobile/view_models/firebase_service.dart';
import 'package:final_project_mobile/view_models/payment_vm.dart';
import 'package:final_project_mobile/widgets/app_bar.dart';
import 'package:final_project_mobile/widgets/bottom_navbar.dart';
import 'package:final_project_mobile/widgets/history_tile.dart';
import 'package:final_project_mobile/widgets/notification_tile.dart';
import 'package:final_project_mobile/widgets/second_app_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../../utils/network.dart';
import '../../view_models/auth_vm.dart';
import '../../widgets/loading_screen.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with DialogMixin {
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    context
        .read<PaymentViewModel>()
        .setNetworkService(context.read<BaseNetwork>());
    context
        .read<AuthViewModel>()
        .setNetworkService(context.read<BaseNetwork>());

    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      final AuthViewModel uvm = context.read<AuthViewModel>();
      context.read<AuthViewModel>().fetchUser().then((value) {
        if (uvm.isLoggedIn != false) {
          context.read<PaymentViewModel>().fetchAllNotifications();
        } else {
          showErrorSnackbar('Silahkan login terlebih dahulu!');
          Get.toNamed<void>('/login');
        }
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
      appBar: SecondAppBar(appBar: AppBar(), title : 'Notifikasi'),
      body:
      Consumer<PaymentViewModel>(
        builder: (_, PaymentViewModel vm, __) {
          if (vm.isLoading) {
            return LoadingScreen();
          } else {
            if (vm.all_notifications.isEmpty) {
              return const Center(
                child: Text('Data notifikasi kosong',
                    style: CustomFont.smallTheme),
              );
            } else {
              return SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: vm.all_notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NotificationTile(vm.all_notifications[index]);
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
