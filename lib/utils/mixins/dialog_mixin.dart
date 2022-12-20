import 'package:final_project_mobile/styles/color.dart';
import 'package:final_project_mobile/styles/font.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

mixin DialogMixin {
  void showSuccessSnackbar(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.white,
      colorText: CustomColor.themedarker,
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
            'Ok',
          ),
          onPressed: Get.back,
        ),
      ],
    );
  }

  Future<void> showSingleWarningDialog(String message) async {
    await Get.defaultDialog<void>(
      title: 'Oops',
      content: Text(
        message,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Ok',
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




}
