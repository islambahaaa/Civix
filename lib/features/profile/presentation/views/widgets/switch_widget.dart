import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({super.key});

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
        activeTrackColor: AppColors.primaryColor,
        activeColor: Colors.white,
        splashRadius: 15,
        value: switchValue,
        onChanged: (value) {
          setState(() {
            switchValue = value;
          });
        });
  }
}
