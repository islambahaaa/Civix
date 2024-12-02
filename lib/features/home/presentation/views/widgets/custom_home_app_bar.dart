import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/notification_widget.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../../../core/utils/app_images.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(Assets.imagesProfileImage),
      title: const Text(
        'صباح الخير !..',
        textAlign: TextAlign.right,
      ),
      subtitle: const Text(
        'getUser().name',
        textAlign: TextAlign.right,
      ),
      trailing: const NotificationWidget(),
    );
  }
}
