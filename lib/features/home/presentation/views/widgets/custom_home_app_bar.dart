import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/notification_widget.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../../../core/utils/app_images.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key, required this.fname, required this.lname});
  final String fname;
  final String lname;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(Assets.imagesProfileImage),
      title: const Text(
        'Hello,',
      ),
      subtitle: Text(
        "$fname $lname",
      ),
      trailing: const NotificationWidget(),
    );
  }
}
