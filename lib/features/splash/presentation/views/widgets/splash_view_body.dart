import 'package:civix_app/constants.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
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
    return Center(
      child: Image.asset(Assets.animationsA),
    );
  }

  void excuiteNavigation() {
    bool isOnBoardingSeen = Prefs.getBool(kIsOnBoardingSeen);
    String? user = Prefs.getString(kUserData);
    Future.delayed(const Duration(milliseconds: 1600), () {
      // //!only temp
      // Navigator.pushReplacementNamed(context, HomeView.routeName);
      // //!only temp
      if (isOnBoardingSeen) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, HomeView.routeName);
        } else {
          Navigator.pushReplacementNamed(context, SigninView.routeName);
        }
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    });
  }
}
