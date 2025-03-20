import 'dart:async';

import 'package:civix_app/core/helper_functions/on_generate_routes.dart';
import 'package:civix_app/core/services/custom_bloc_observer.dart';
import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/features/report/presentation/views/location_pick.dart';
import 'package:civix_app/features/splash/presentation/views/splash_view.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:civix_app/language/lang_cubit.dart';
import 'package:civix_app/features/report_details/presentation/views/test_report_details.dart';
import 'package:civix_app/theme/theme.dart';
import 'package:civix_app/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = CustomBlocObserver();
  await Prefs.init();
  setupGetIt();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(create: (context) => LanguageCubit()..loadSavedLanguage()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, theme) {
          return BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                title: 'Civix',
                locale: locale,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: theme,
                debugShowCheckedModeBanner: false,
                // onGenerateRoute: onGenerateRoute,
                // initialRoute: SplashView.routeName,
                home: const ItemDetailsScreen(
                  title: "Damaged Street Light",
                  description: "A broken street light at the main road.",
                  status: "Pending",
                  dateTime: "20/12/2025",
                  location: LatLng(37.7749, -122.4194), // Example coordinates
                  images: [
                    "https://civix.runasp.net/uploads/0d0a6439-f3f3-4636-83ca-96a98775355f.jpg",
                    "https://civix.runasp.net/uploads/1a1f2e67-aa2c-47f6-b1b3-081e71b69ac4.jpg",
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
