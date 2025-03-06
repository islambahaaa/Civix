import 'package:civix_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../utils/app_images.dart';

class NotificationItem extends StatelessWidget {
  final int notificationCount;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.notificationCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).cardTheme.color, // Light primary color
            ),
            child: SvgPicture.asset(
              Assets.imagesNotification,
              width: 26,
            ),
          ),
        ),
        if (notificationCount > 0)
          Positioned(
            left: 0,
            top: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                notificationCount > 99 ? '99+' : notificationCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
