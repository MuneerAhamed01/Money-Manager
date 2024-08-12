import 'package:flutter/material.dart';
import 'package:money_manager/themes/colors.dart';
import 'package:money_manager/themes/fonts.dart';

class AppInputDecorationTheme extends InputDecorationTheme {
  AppInputDecorationTheme()
      : super(
          alignLabelWithHint: false,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(false, true),
          errorBorder: _border(true),
          focusedErrorBorder: _border(),
          contentPadding: const EdgeInsets.all(14),
          labelStyle: AppTextTheme.instance.bodyMedium,
          disabledBorder: _border(),
          filled: false,
          iconColor: Colors.black,
          suffixIconColor: Colors.black,
          hintStyle: AppTextTheme.instance.bodyMedium?.copyWith(
              color: AppColors.hintTextColor, fontWeight: FontWeight.w400),
          floatingLabelStyle: AppTextTheme.instance.labelMedium,
          helperStyle: AppTextTheme.instance.labelMedium,
        );

  static OutlineInputBorder _border(
      [bool isError = false, bool isEnable = false]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: isError
            ? AppColors.errorColor
            : isEnable
                ? Colors.black
                : AppColors.hintTextColor,
      ),
    );
  }
}
