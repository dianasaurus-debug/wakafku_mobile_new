import 'package:final_project_mobile/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../styles/font.dart';

mixin DialogMixin {
  void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: CustomColor.theme,
      colorText: Colors.white,
    );
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      'Oops',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  Future<void> showWarningDialog(List<dynamic> messages) async {
    await Get.defaultDialog<void>(
      title: 'Warning',
      content: Column(
        children: List<Widget>.generate(
          messages.length,
          (int index) => Text(
            '- ${messages[index]}',
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'OK',
          ),
          onPressed: Get.back,
        ),
      ],
    );
  }

  Future<void> showSingleWarningDialog(String message) async {
    await Get.defaultDialog<void>(
      title: 'Warning',
      content: Text(
        message,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'OK',
          ),
          onPressed: Get.back,
        ),
      ],
    );
  }

  Future<void> showSingleActionDialog(
    String title,
    String message,
    String buttonText,
    void Function() onTap,
  ) async {
    await Get.defaultDialog<void>(
      title: title,
      content: Text(
        message,
      ),
      onWillPop: () async {
        onTap();
        return true;
      },
      actions: <Widget>[
        TextButton(
          child: Text(
            buttonText,
          ),
          onPressed: onTap,
        ),
      ],
    );
  }

  Future<void> showDoubleActionDialog(
    String title,
    String message,
    String buttonText,
    String buttonText2,
    void Function() onTap,
    void Function() onTap2,
  ) async {
    await Get.defaultDialog<void>(
      contentPadding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      title: title,
      content: Text(
        message,
        style: CustomFont.blackMedLight,
      ),
      onWillPop: () async {
        onTap();
        return true;
      },
      actions: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          ElevatedButton(
              child: Text(buttonText.toUpperCase(),
                  style: CustomFont.textInfoWhiteLight),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(CustomColor.theme),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColor.theme),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: CustomColor.theme)))),
              onPressed: () => null),
          ElevatedButton(
              child: Text(buttonText2.toUpperCase(),
                  style: CustomFont.textInfoWhiteLight),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(CustomColor.theme),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(CustomColor.theme),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: CustomColor.theme)))),
              onPressed: () => null)
        ])
      ],
    );
  }

  void showMyBottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => child,
      backgroundColor: Colors.transparent,
    );
  }

  void showGetBottomSheet(Widget child) {
    Get.bottomSheet(child);
  }
  showFailedDialog(
      {required BuildContext context,
        required String title,
        Color? color}) {
    Alert(
      style: AlertStyle(
          animationType: AnimationType.grow,
          isCloseButton: false,
          alertElevation: 0,
          overlayColor: Colors.black.withOpacity(0.5),
          buttonAreaPadding: EdgeInsets.all(10)),
      context: context,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info_outline, color: color ?? Colors.red, size: 80),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          const Text(
            'Silahkan coba lagi',
            style: TextStyle(color : Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              onSurface: Colors.white,
              backgroundColor: color ?? Colors.red,
              textStyle: TextStyle(color : Colors.white),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: Size.fromHeight(40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
            child: const Text('Coba Lagi', style: TextStyle(color : Colors.white)),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      buttons: [],
    ).show();
  }
}
