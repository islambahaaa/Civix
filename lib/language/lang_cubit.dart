import 'package:bloc/bloc.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class LanguageCubit extends Cubit<Locale> {
  static const String _languageKey = "selected_language";

  LanguageCubit() : super(_getDefaultLocale());

  static Locale _getDefaultLocale() {
    Locale deviceLocale = PlatformDispatcher.instance.locale;
    return deviceLocale;
  }

  /// Load saved language from SharedPreferences
  Future<void> loadSavedLanguage() async {
    String? savedLanguageCode = Prefs.getString(_languageKey);

    if (savedLanguageCode != null) {
      emit(Locale(savedLanguageCode));
    } else {
      emit(_getDefaultLocale());
    }
  }

  /// Change language and save preference
  Future<void> changeLanguage(Locale newLocale) async {
    await Prefs.setString(_languageKey, newLocale.languageCode);
    emit(newLocale);
  }
}
