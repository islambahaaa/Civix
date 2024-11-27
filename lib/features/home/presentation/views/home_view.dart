import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:civix_app/features/home/presentation/views/widgets/google_bottom_nav_bar.dart';
import 'package:civix_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String routeName = 'home_view';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: GoogleNavBotoomBar(),
      // CustomBottomNavigationBar(),
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
