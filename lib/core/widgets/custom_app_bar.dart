import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar({context, required String text, Widget? leading}) {
  return AppBar(
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0,
    title: Text(
      text,
      style: TextStyles.bold19,
    ),
    actions: [
      leading ?? const SizedBox(),
    ],
    leading: context == null
        ? null
        : GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
          ),
    centerTitle: true,
  );
}
