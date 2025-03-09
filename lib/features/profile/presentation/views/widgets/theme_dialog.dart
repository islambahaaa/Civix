import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:civix_app/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showThemeDialog(BuildContext context) {
  final cubit = context.read<ThemeCubit>();
  ThemeMode currentMode = cubit.state; // Get current theme

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(S.of(context).select_theme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildThemeTile(context, S.of(context).system_default,
                ThemeMode.system, currentMode),
            buildThemeTile(context, S.of(context).light_mode, ThemeMode.light,
                currentMode),
            buildThemeTile(
                context, S.of(context).dark_mode, ThemeMode.dark, currentMode),
          ],
        ),
      );
    },
  );
}

Widget buildThemeTile(
    BuildContext context, String title, ThemeMode mode, ThemeMode currentMode) {
  return RadioListTile<ThemeMode>(
    activeColor: AppColors.primaryColor,
    title: Text(title),
    value: mode,
    groupValue: currentMode, // Checks the selected option
    onChanged: (newMode) {
      if (newMode == ThemeMode.system) {
        context.read<ThemeCubit>().followSystemTheme();
      } else if (newMode == ThemeMode.dark) {
        context.read<ThemeCubit>().toggleTheme(true);
      } else {
        context.read<ThemeCubit>().toggleTheme(false);
      }
      Navigator.pop(context); // Close the dialog
    },
  );
}
