import 'package:civix_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'inter',
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.secondaryColor,
    ),
    cardTheme: const CardTheme(color: AppColors.lightprimaryColor2),
    // Use light icons in dark mode
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'inter',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      // primary: Colors.grey.shade900,
      primary: AppColors.secondaryColor,
      secondary: Colors.grey.shade600,
      tertiary: Colors.grey.shade400,
    ),
    cardTheme: CardTheme(color: Colors.grey.shade900),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.light, // Use light icons in dark mode
      ),
    ),
    //scaffoldBackgroundColor: Colors.grey.shade900,
  );
}
