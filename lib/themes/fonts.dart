import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme extends TextTheme {
  static String fontFamily = GoogleFonts.inter().fontFamily!;

  static const AppTextTheme instance = AppTextTheme._();

//create a singleton
  const AppTextTheme._();

  @override
  TextStyle? get displayLarge {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 57,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  TextStyle? get displayMedium {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 45,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  TextStyle? get displaySmall {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 36,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  TextStyle? get headlineLarge {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  TextStyle? get headlineMedium {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  TextStyle? get headlineSmall {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  TextStyle? get titleLarge {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  TextStyle? get titleMedium {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  TextStyle? get titleSmall {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  TextStyle? get labelLarge {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  TextStyle? get labelMedium {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  TextStyle? get labelSmall {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    );
  }

  @override
  TextStyle? get bodyLarge {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  TextStyle? get bodyMedium {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      
    );
  }

  @override
  TextStyle? get bodySmall {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    );
  }
}
