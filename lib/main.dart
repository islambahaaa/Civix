import 'dart:async';

import 'package:civix_app/core/helper_functions/on_generate_routes.dart';
import 'package:civix_app/core/services/custom_bloc_observer.dart';
import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = CustomBlocObserver();
  await Prefs.init();
  setupGetIt();
  runZonedGuarded(() {
    runApp(const MainApp());
  }, (error, stackTrace) {
    print("Uncaught error: $error");
    print("Stack trace: $stackTrace");
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'inter',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondaryColor),
        scaffoldBackgroundColor: Colors.white,
      ),
      onGenerateRoute: onGenerateRoute,
      initialRoute: SplashView.routeName,
    );
  }
}
