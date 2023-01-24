import 'package:final_project_mobile/screens/program/waqf_form/confirmation_form.dart';
import 'package:final_project_mobile/screens/transaction/notification.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
late FirebaseMessaging messaging;

class FirebaseService {
  static Future<Uri> createOrderDynamicLink(bool isFailed, int id) async {
    String _linkMessage;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://ninuninutest.page.link',
      link: Uri.parse(
          'https://ninuninutest.page.link/checkout?id=${id}&is_failed=${isFailed}'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.kitsune_app',
        minimumVersion: 1,
      ),
    );

    Uri url;
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    url = shortLink.shortUrl;
    return url;
  }
  static void inAppFirebaseNotif(){
    messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      showSimpleNotification(
        Text(event.notification!.title!, style: CustomFont.blackMedBold),
        subtitle:
        Text(event.notification!.body!, style: CustomFont.smallTheme),
        background: Colors.white,
        duration: const Duration(seconds: 20),
        elevation: 2,
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Get.to(NotificationPage());
    });
  }
  static Future<void> initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri deepLink = dynamicLink!.link;
      print(deepLink);

      // TODO :Modify Accordingly
      String? id = deepLink.queryParameters['id'];
      bool? status =
          deepLink.queryParameters['is_failed'] == 'false' ? false : true;
      print(deepLink);

      // TODO :Modify Accordingly
      print('id is : ${id}');

      if (deepLink != null) {
        // TODO : Navigate to your pages accordingly here
        print('berhasil ke route dengan status : ${status}');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ConfirmationForm()));
      } else {
        return null;
      }
    }, onError: (OnLinkErrorException e) async {
      print('link error');
    });
  }
}
