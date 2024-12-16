import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:civix_app/features/home/presentation/views/widgets/google_bottom_nav_bar.dart';
import 'package:civix_app/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  static const String routeName = 'home_view';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..fetchUser(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.secondaryColor,
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.white, size: 30)),
        bottomNavigationBar: const GoogleNavBotoomBar(),
        body: const SafeArea(child: HomeViewBody()),
      ),
    );
  }
}
