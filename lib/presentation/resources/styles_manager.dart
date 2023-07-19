
import 'package:flutter/cupertino.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontsize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontsize,
      fontFamily: FontConstants.fontFamily,
      fontWeight: fontWeight,
      color: color);
}

TextStyle getRegularTextStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

TextStyle getMediumTextStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

TextStyle getLightTextStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

TextStyle getBoldTextStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

TextStyle getSemiBoldTextStyle(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
