import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/language/lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';

void showLanguageDialog(BuildContext context) {
  final currentLocale = context.read<LanguageCubit>().state;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.current.language), // "Language" translated
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _languageOption(
                context, "English", const Locale('en'), currentLocale),
            _languageOption(
                context, "العربية", const Locale('ar'), currentLocale),
          ],
        ),
      );
    },
  );
}

Widget _languageOption(BuildContext context, String language, Locale locale,
    Locale currentLocale) {
  return RadioListTile<Locale>(
    activeColor: AppColors.primaryColor,
    groupValue: currentLocale,
    title: Text(language),
    value: locale,
    onChanged: (value) {
      context.read<LanguageCubit>().changeLanguage(locale);
      Navigator.pop(context);
    },
  );
}
