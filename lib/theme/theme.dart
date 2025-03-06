import 'package:civix_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'inter',
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'inter',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.grey.shade900,
      secondary: Colors.grey.shade600,
      tertiary: Colors.grey.shade400,
    ),
    //scaffoldBackgroundColor: Colors.grey.shade900,
  );
}
