import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> with WidgetsBindingObserver {
  ThemeCubit() : super(ThemeMode.system) {
    // Listen to system theme changes
    WidgetsBinding.instance.addObserver(this);
    _loadThemePreference();
  }

  bool _isManualSelection = false;

  void toggleTheme(bool isDark) async {
    _isManualSelection = true;
    ThemeMode newTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    await Prefs.setString('themeMode', newTheme.toString());
    emit(newTheme);
  }

  void followSystemTheme() async {
    _isManualSelection = false;
    await Prefs.setString('themeMode', 'system');
    _updateThemeMode();
  }

  void _loadThemePreference() async {
    String? savedTheme = Prefs.getString('themeMode');

    if (savedTheme == 'ThemeMode.dark') {
      _isManualSelection = true;
      emit(ThemeMode.dark);
    } else if (savedTheme == 'ThemeMode.light') {
      _isManualSelection = true;
      emit(ThemeMode.light);
    } else {
      _isManualSelection = false;
      _updateThemeMode();
    }
  }

  void _updateThemeMode() {
    if (!_isManualSelection) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      emit(brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light);
    }
  }

  @override
  void didChangePlatformBrightness() {
    _updateThemeMode();
    super.didChangePlatformBrightness();
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
