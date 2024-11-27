import 'package:civix_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
import 'package:civix_app/features/home/presentation/views/home_view.dart';
import 'package:civix_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:civix_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
