import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class TFilledButtonTheme {
  TFilledButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightFilledButtonTheme  = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      alignment: Alignment.center,
      elevation: 0,
      foregroundColor: TColors.white,
      backgroundColor: TColors.primary,
      surfaceTintColor: TColors.primary,
      disabledForegroundColor: TColors.darkGrey,
      disabledBackgroundColor: TColors.buttonDisabled,
      side: BorderSide(color: TColors.grey.withOpacity(0), width:1),
      minimumSize: const Size(double.minPositive, 47),
      padding: const EdgeInsets.symmetric(vertical: 5),
      textStyle: const TextStyle(fontSize: 16, color: TColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      alignment: Alignment.center,
      elevation: 0,
      foregroundColor: TColors.white,
      backgroundColor: TColors.primary,
      disabledForegroundColor: TColors.black,
      disabledBackgroundColor: TColors.buttonDisabled,
      side: BorderSide(color: TColors.primary.withOpacity(0), width: 0),
      minimumSize: const Size(double.minPositive, 47),
      padding: const EdgeInsets.symmetric(vertical: 5),
      textStyle: const TextStyle(fontSize: 16, color: TColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.buttonRadius)),
    ),
  );
}
