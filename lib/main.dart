import 'dart:async';
import 'dart:developer';

import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/background_not_handler.dart';
import 'package:civix_app/core/helper_functions/on_generate_routes.dart';
import 'package:civix_app/core/services/custom_bloc_observer.dart';
import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/services/notification_service.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/core/services/signalr_service.dart';
import 'package:civix_app/features/notifications/data/models/notification_model.dart';
import 'package:civix_app/features/notifications/presentation/views/notification_view.dart';
import 'package:civix_app/features/report/presentation/views/location_pick.dart';
import 'package:civix_app/features/splash/presentation/views/splash_view.dart';
import 'package:civix_app/core/services/firebase_notification_service.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:civix_app/language/lang_cubit.dart';
import 'package:civix_app/theme/theme.dart';
import 'package:civix_app/theme/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseNotificationService.initialize();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(NotificationModelAdapter());
  }
  await Hive.openBox<NotificationModel>(kNotificationsBox);

  Bloc.observer = CustomBlocObserver();
  await Prefs.init();
  setupGetIt();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await dotenv.load();
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
                onGenerateRoute: onGenerateRoute,
                initialRoute: SplashView.routeName,
                //
                //home: const NotificationsPage(),
              );
            },
          );
        },
      ),
    );
  }
}
