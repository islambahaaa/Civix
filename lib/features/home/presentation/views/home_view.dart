import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/home/domain/repos/home_repo.dart';
import 'package:civix_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:civix_app/features/home/presentation/views/widgets/bottom_nav_bar.dart';
import 'package:civix_app/features/profile/presentation/views/profile_view.dart';
import 'package:civix_app/features/report/presentation/views/report_view.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:civix_app/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  static const String routeName = 'home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _onNavItemTapped(int index) {
    pageController.jumpToPage(
      index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit()..fetchUser(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            getIt.get<HomeRepo>(),
          )..fetchMyReports(),
        ),
      ],
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
        ),
        child: Scaffold(
          floatingActionButton: currentIndex != 0
              ? null
              : FloatingActionButton.extended(
                  label: Text(
                    S.of(context).report,
                    style:
                        TextStyles.regular14inter.copyWith(color: Colors.white),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 24),
                  splashColor: AppColors.primaryColor,
                  backgroundColor: AppColors.secondaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, ReportView.routeName);
                  },
                ),
          bottomNavigationBar: BottomNavBar(
            selectedIndex: currentIndex,
            onItemSelected: (index) {
              _onNavItemTapped(index);
            },
          ),
          body: SafeArea(
            child: PageView(
              controller: pageController,
              onPageChanged: _onPageChanged,
              children: [
                HomeViewBody(
                  onNameTap: () {
                    pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutExpo);
                  },
                ),
                const ProfileView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class navigationBar extends StatelessWidget {
//   const navigationBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return NavigationBarTheme(
//       data: NavigationBarThemeData(
//         indicatorShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         labelTextStyle: WidgetStateProperty.all(TextStyles.regular14inter),
//       ),
//       child: NavigationBar(
//           height: 90,
//           selectedIndex: 0,
//           elevation: 0,
//           indicatorColor: AppColors.primaryColor,
//           destinations: const [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
//               child: NavigationDestination(
//                   selectedIcon: Icon(
//                     Icons.ac_unit,
//                   ),
//                   icon: Icon(
//                     Icons.home,
//                     size: 35,
//                   ),
//                   label: 'Home'),
//             ),
//             NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
//             NavigationDestination(
//                 icon: Icon(Icons.notifications), label: 'Alerts'),
//           ]),
//     );
//   }
// }
