import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

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
          spreadRadius: 1,
          blurRadius: 4,
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
                          color: isSelected
                              ? AppColors.lightprimaryColor.withOpacity(0.3)
                              : null,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          index == 0
                              ? isSelected
                                  ? Icons.home
                                  : Icons.home_outlined
                              : index == 1
                                  ? isSelected
                                      ? Icons.notifications
                                      : Icons.notifications_none_outlined
                                  : isSelected
                                      ? Icons.person
                                      : Icons.person_outline_outlined,
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(
                          index == 0
                              ? 'Home'
                              : index == 1
                                  ? 'Notifications'
                                  : 'Profile',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
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
