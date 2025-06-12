import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/home/domain/repos/home_repo.dart';
import 'package:civix_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:civix_app/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:civix_app/features/my_reports/domain/repos/my_reports_repo.dart';
import 'package:civix_app/features/my_reports/presentation/cubit/my_reports_cubit.dart';
import 'package:civix_app/features/my_reports/presentation/views/my_reports_view.dart';
import 'package:civix_app/features/notifications/presentation/views/notification_view.dart';
import 'package:civix_app/features/profile/presentation/views/profile_view.dart';
import 'package:civix_app/features/report/presentation/views/images_pick_view.dart';
import 'package:civix_app/features/report/presentation/views/report_view.dart';
import 'package:civix_app/core/services/firebase_notification_service.dart';
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
  final firebaseService = getIt.get<FirebaseNotificationService>();
  @override
  void initState() {
    super.initState();
    firebaseService.requestPermission();
    firebaseService.getToken();
    firebaseService.setupOnMessageListener();
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
          create: (context) => MyReportsCubit(
            getIt.get<MyReportsRepo>(),
          )..fetchMyReports(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            getIt.get<HomeRepo>(),
          )..fetchNearMe(),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: currentIndex == 3
              ? null
              : SizedBox(
                  height: 150,
                  width: 70,
                  child: FloatingActionButton(
                    tooltip: S.of(context).report,
                    shape: const CircleBorder(),
                    splashColor: AppColors.primaryColor,
                    backgroundColor: AppColors.secondaryColor,
                    onPressed: () {
                      Navigator.pushNamed(context, ImagesPickView.routeName);
                    },
                    child: const Icon(Icons.add, color: Colors.white, size: 32),
                  ),
                ),
          // bottomNavigationBar: NavigationExample(),
          bottomNavigationBar: CustomBottomNavBar(
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
                    pageController.animateToPage(3,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutExpo);
                  },
                ),
                const NotificationsPage(),
                const MyReportsView(),
                const ProfileView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
