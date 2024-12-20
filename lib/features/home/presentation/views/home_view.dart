import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:civix_app/features/home/presentation/views/widgets/google_bottom_nav_bar.dart';
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
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..fetchUser(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.secondaryColor,
            onPressed: () {},
            child: const Icon(Icons.add, color: Colors.white, size: 30)),
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
                child: Text('Profile'),
              ),
              Center(
                child: Text('Alerts'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class navigationBar extends StatelessWidget {
  const navigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        labelTextStyle: WidgetStateProperty.all(TextStyles.regular14inter),
      ),
      child: NavigationBar(
          height: 90,
          selectedIndex: 0,
          elevation: 0,
          indicatorColor: AppColors.primaryColor,
          destinations: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              child: NavigationDestination(
                  selectedIcon: Icon(
                    Icons.ac_unit,
                  ),
                  icon: Icon(
                    Icons.home,
                    size: 35,
                  ),
                  label: 'Home'),
            ),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            NavigationDestination(
                icon: Icon(Icons.notifications), label: 'Alerts'),
          ]),
    );
  }
}

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ]),
      width: double.infinity,
      height: 80,
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryColor : null,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          index == 0
                              ? Icons.home
                              : index == 1
                                  ? Icons.done_outline_rounded
                                  : Icons.person,
                          color: isSelected ? Colors.black : Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(
                          index == 0
                              ? 'Home'
                              : index == 1
                                  ? 'Solved Issues'
                                  : 'Profile',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
