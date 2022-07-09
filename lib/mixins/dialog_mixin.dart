import 'package:final_project_mobile/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
}
