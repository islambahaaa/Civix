import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/home/presentation/views/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return BlocProvider(
      create: (context) => UserCubit()..fetchUser(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            'Report an issue',
            style: TextStyles.regular14inter.copyWith(color: Colors.white),
          ),
          icon: const Icon(Icons.add, color: Colors.white, size: 24),
          splashColor: AppColors.primaryColor,
          backgroundColor: AppColors.secondaryColor,
          onPressed: () {},
        ),
        bottomNavigationBar: CustomNavigationBar(
          selectedIndex: currentIndex,
          onItemSelected: (index) {
            _onNavItemTapped(index);
          },
        ),
        body: SafeArea(
          child: PageView(
            controller: pageController,
            onPageChanged: _onPageChanged,
            children: const [
              HomeViewBody(),
              Center(
                child: Text('Solved Issues'),
              ),
              Center(
                child: Text('Profile'),
              ),
            ],
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
