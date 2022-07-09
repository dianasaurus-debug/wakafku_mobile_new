import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class CustomFont {
  static const TextStyle introTitle = TextStyle(fontSize: 30, color: CustomColor.theme, fontWeight: FontWeight.w900);
  static const TextStyle appBar = TextStyle(fontSize: 24, color: CustomColor.theme, fontWeight: FontWeight.w600);
  static const TextStyle basicText = TextStyle(fontSize: 15, color: CustomColor.themedarkest);
  static const TextStyle basicTextgrey = TextStyle(fontSize: 16, color: CustomColor.mutedButton);
  static const TextStyle noticeText = TextStyle(fontSize: 15, color: CustomColor.theme);
  static const TextStyle basicText2 = TextStyle(fontSize: 17, color: CustomColor.text);
  static const TextStyle option = TextStyle(fontSize: 18, color: CustomColor.text);
  static const TextStyle basicTitle = TextStyle(fontSize: 23, color: CustomColor.text, fontWeight: FontWeight.w400);
  static const TextStyle basicTitleSplash = TextStyle(fontSize: 30, color: CustomColor.text, fontWeight: FontWeight.w600);
  static const TextStyle smallMuted = TextStyle(fontSize: 16, color: CustomColor.mutedText, fontWeight: FontWeight.w500);
  static const TextStyle smallMutedDarker =
  TextStyle(fontSize: 17, color: CustomColor.mutedTextDarker);
  static const TextStyle smallTheme = TextStyle(fontSize: 15, color: CustomColor.theme);
  static const TextStyle signIn = TextStyle(fontSize: 15, color: CustomColor.theme, fontWeight: FontWeight.w700);
  static const TextStyle signInBlack = TextStyle(fontSize: 15, color: CustomColor.text, fontWeight: FontWeight.w700);
  static const TextStyle textBasicWhiteLight =
  TextStyle(fontSize: 10, color: CustomColor.white1);
  static const TextStyle textBasicWhiteBold = TextStyle(
      fontSize: 10, color: CustomColor.white1, fontWeight: FontWeight.bold);
  static const TextStyle textInfoWhiteLight =
  TextStyle(color: CustomColor.white1, fontWeight: FontWeight.bold);

  static const TextStyle textMedWhiteLight =
  TextStyle(color: CustomColor.white1);
  static const TextStyle textMedWhiteBold = TextStyle(
      fontSize: 10, color: CustomColor.white1, fontWeight: FontWeight.bold);

  static const TextStyle regist =
  TextStyle(fontSize: 18, color: CustomColor.mutedText);
  static const TextStyle accept =
  TextStyle(fontSize: 16, color: CustomColor.theme);
  static const TextStyle reject = TextStyle(fontSize: 16, color: Colors.red);
  static const TextStyle waiting = TextStyle(fontSize: 16, color: Colors.blue);
  static const TextStyle smallerMuted = TextStyle(
      fontSize: 13,
      color: CustomColor.mutedText,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic);
  static const TextStyle bigTheme = TextStyle(
      fontSize: 50, color: CustomColor.theme, fontWeight: FontWeight.w600);
  static const TextStyle bigMuted = TextStyle(
      fontSize: 50,
      color: CustomColor.mutedButton,
      fontWeight: FontWeight.w600);
  static const TextStyle blackBold =
  TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle orangeBigBold = TextStyle(
      fontSize: 18, color: CustomColor.theme, fontWeight: FontWeight.bold);
  static const TextStyle orangeMedBold = TextStyle(
      fontSize: 14, color: CustomColor.theme, fontWeight: FontWeight.bold);
  static const TextStyle orangeMedLight =
  TextStyle(fontSize: 14, color: CustomColor.theme);
  static const TextStyle orangesmallBold = TextStyle(
      fontSize: 12, color: CustomColor.theme, fontWeight: FontWeight.bold);
  static const TextStyle orangesmallLight =
  TextStyle(fontSize: 12, color: CustomColor.theme);

  static const TextStyle blackBigBold = TextStyle(
      fontSize: 18,
      color: CustomColor.themedarkest,
      fontWeight: FontWeight.bold);
  static const TextStyle blackMedBold = TextStyle(
      fontSize: 14,
      color: CustomColor.themedarkest,
      fontWeight: FontWeight.bold);
  static const TextStyle blackMedLight =
  TextStyle(fontSize: 14, color: CustomColor.themedarkest);
  static const TextStyle blackSmallight =
  TextStyle(fontSize: 12, color: CustomColor.themedarkest);

  static const TextStyle blackBigLight =
  TextStyle(fontSize: 18, color: CustomColor.themedarkest);
  static const TextStyle blackSmallBold = TextStyle(
      fontSize: 12,
      color: CustomColor.themedarkest,
      fontWeight: FontWeight.bold);
  static const TextStyle blackTinyLight =
  TextStyle(fontSize: 10, color: CustomColor.themedarkest);
  static const TextStyle blackTinyBold = TextStyle(
      fontSize: 10,
      color: CustomColor.themedarkest,
      fontWeight: FontWeight.bold);
  static const TextStyle discBlackText = TextStyle(
      color: CustomColor.themedarkest,
      fontWeight: FontWeight.bold,
      decorationColor: CustomColor.theme,
      decorationStyle: TextDecorationStyle.solid,
      decoration: TextDecoration.lineThrough);
  static const TextStyle darkerBigBold = TextStyle(
      fontSize: 18,
      color: CustomColor.themedarker,
      fontWeight: FontWeight.bold);
  static const TextStyle darkerBigLight =
  TextStyle(fontSize: 18, color: CustomColor.themedarker);
  static const TextStyle darkerMedBold = TextStyle(
      fontSize: 14,
      color: CustomColor.themedarker,
      fontWeight: FontWeight.bold);
  static const TextStyle darkerMedLight =
  TextStyle(fontSize: 14, color: CustomColor.themedarker);
  static const TextStyle darkerSmallight =
  TextStyle(fontSize: 12, color: CustomColor.themedarker);
  static const TextStyle darkerSmallBold = TextStyle(
      fontSize: 12,
      color: CustomColor.themedarker,
      fontWeight: FontWeight.bold);
  static const TextStyle darkerTinyLight =
  TextStyle(fontSize: 10, color: CustomColor.themedarker);
  static const TextStyle darkerTinyBold = TextStyle(
      fontSize: 10,
      color: CustomColor.themedarker,
      fontWeight: FontWeight.bold);

  static const TextStyle discBlackTextSmall = TextStyle(
      fontSize: 12,
      color: CustomColor.themedarkest,
      fontWeight: FontWeight.bold,
      decorationColor: CustomColor.theme,
      decorationStyle: TextDecorationStyle.solid,
      decoration: TextDecoration.lineThrough);

  static const TextStyle discBlackTextTiny = TextStyle(
      fontSize: 10,
      color: CustomColor.themedarkest,
      fontWeight: FontWeight.bold,
      decorationColor: CustomColor.theme,
      decorationStyle: TextDecorationStyle.solid,
      decoration: TextDecoration.lineThrough);

  static const TextStyle whiteLargeBold = TextStyle(
      fontSize: 22, color: CustomColor.whitebg, fontWeight: FontWeight.bold);
  static const TextStyle whiteBigBold = TextStyle(
      fontSize: 18, color: CustomColor.whitebg, fontWeight: FontWeight.bold);
  static const TextStyle whiteBigLight =
  TextStyle(fontSize: 18, color: CustomColor.whitebg);
  static const TextStyle whiteMedBold = TextStyle(
      fontSize: 14, color: CustomColor.whitebg, fontWeight: FontWeight.bold);
  static const TextStyle whiteMedLight =
  TextStyle(fontSize: 14, color: CustomColor.whitebg);
  static const TextStyle whiteSmallight =
  TextStyle(fontSize: 12, color: CustomColor.whitebg);
  static const TextStyle whiteSmallBold = TextStyle(
      fontSize: 12, color: CustomColor.whitebg, fontWeight: FontWeight.bold);
}
