import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });
  Widget buildNavItem({required IconData icon, required int index}) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          enableFeedback: false,
          onTap: () => onItemSelected(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                waitDuration: const Duration(milliseconds: 50),
                message:
                    getTabName(index), // Shows "Home", "Notifications", etc.
                child: Icon(
                  icon,
                  size: 30,
                  color: selectedIndex == index
                      ? AppColors.primaryColor
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getTabName(int index) {
    switch (index) {
      case 0:
        return S.current.home;
      case 1:
        return S.current.notifications;
      case 2:
        return S.current.prev_submissions;
      case 3:
        return S.current.profile;
      default:
        return S.current.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.transparent
                : Colors.grey.withOpacity(0.3),
            offset: const Offset(0, -1),
            blurRadius: 8,
          ),
        ],
      ),
      child: BottomAppBar(
        //color: Theme.of(context).bottomAppBarTheme.color,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildNavItem(icon: Icons.home, index: 0),
            buildNavItem(icon: Icons.notifications, index: 1),
            if (selectedIndex != 3) const SizedBox(width: 50),
            buildNavItem(icon: Icons.history, index: 2),
            buildNavItem(icon: Icons.person, index: 3),
          ],
        ),
      ),
    );
  }
}
