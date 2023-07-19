
import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    //colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,
    //card Theme
    cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: AppSize.s4,
        shadowColor: ColorManager.grey),
    //appbar
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.lightPrimary,
        titleTextStyle: getRegularTextStyle(
            color: ColorManager.white, fontSize: FontSizeManager.s16)),
    //button theme

    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),
    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularTextStyle(
                color: ColorManager.white, fontSize: FontSizeManager.s17),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12))))
    //text theme
    ,
    textTheme: TextTheme(
        displayLarge:
            getLightTextStyle(color: ColorManager.darkGrey, fontSize: AppSize.s16),
        headlineLarge: getSemiBoldTextStyle(
            color: ColorManager.darkGrey, fontSize: FontSizeManager.s16),
        headlineMedium: getRegularTextStyle(
            color: ColorManager.darkGrey, fontSize: FontSizeManager.s14),
        titleLarge: getMediumTextStyle(
            color: ColorManager.lightGrey, fontSize: AppSize.s14),
            titleMedium:getMediumTextStyle(
            color: ColorManager.primary, fontSize: AppSize.s16) ,
        bodyLarge: getRegularTextStyle(color: ColorManager.grey1),
        bodySmall: getRegularTextStyle(color: ColorManager.grey)),
    //input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularTextStyle(
          color: ColorManager.grey, fontSize: FontSizeManager.s14),
      labelStyle: getMediumTextStyle(
          color: ColorManager.grey, fontSize: FontSizeManager.s14),
      errorStyle: getRegularTextStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey.withOpacity(0.4),
          width: AppSize.s2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder:  OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder:  OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
  );
}
