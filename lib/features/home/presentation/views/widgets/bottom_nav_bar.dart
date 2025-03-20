import 'package:civix_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      width: double.infinity,
      child: NavigationBar(
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
          ),
        ),
        labelPadding: const EdgeInsets.all(4),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorColor: Theme.of(context).cardTheme.color,
        onDestinationSelected: onItemSelected,
        selectedIndex: selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            selectedIcon: const Icon(
              Icons.home,
              color: AppColors.primaryColor,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: const Icon(
              Icons.person,
              color: AppColors.primaryColor,
            ),
            icon: Icon(
              Icons.person_outline_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
