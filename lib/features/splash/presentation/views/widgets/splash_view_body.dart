import 'package:civix_app/constants.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/features/home/presentation/views/home_view.dart';
import 'package:civix_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    excuiteNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center();
  }

  void excuiteNavigation() {
    bool isOnBoardingSeen = Prefs.getBool(kIsOnBoardingSeen);
    Future.delayed(const Duration(seconds: 2), () {
      if (!isOnBoardingSeen) {
        // var isLoggedIn = FirebaseAuthService().isLoggedIn();
        //if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, HomeView.routeName);
        //} else {
        //  Navigator.pushReplacementNamed(context, SigninView.routeName);
        //}
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    });
  }
}
