import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class NewestReportsHeader extends StatelessWidget {
  const NewestReportsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "My Reports",
          style: TextStyles.bold28insturment.copyWith(
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
