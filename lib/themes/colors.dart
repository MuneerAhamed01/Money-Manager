import 'package:flutter/material.dart';

class AppColors extends ColorScheme {
  static const Color hintTextColor = Color(0xFF8991A5);
  static const Color errorColor = Color(0xFFBA1A1A);

  const AppColors({
    super.brightness = Brightness.light,
    // super.primary = primary40,
    // super.primaryContainer = Colors.black,
    // super.onPrimaryContainer = primary10,
    // super.onPrimary = white,
    // super.secondary = secondary40,
    // super.secondaryContainer = secondary90,
    // super.onSecondaryContainer = secondary10,
    // super.onSecondary = white,
    // super.tertiary = tertiary40,
    super.tertiaryContainer = Colors.black,
    super.primary = Colors.black,
    super.onPrimary = Colors.black,
    super.secondary = Colors.black,
    super.onSecondary = Colors.black,
    super.error = errorColor,
    super.onError = errorColor,
    super.surface = Colors.white,
    super.onSurface = Colors.black,
    // super.onTertiaryContainer = tertiary10,
    // super.onTertiary = white,
    // super.error = error40,
    // super.errorContainer = white,
    // super.onErrorContainer = error10,
    // super.onError = white,
    // super.background = neutral99,
    // super.onBackground = neutral10,
    // super.surface = neutral99,
    // super.onSurface = neutral10,
    // super.surfaceVariant = neutralVariant90,
    // super.onSurfaceVariant = neutralVariant30,
    super.outline = hintTextColor,
  });
}
