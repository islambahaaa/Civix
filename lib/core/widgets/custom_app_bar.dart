import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar({context, required String text, Widget? leading}) {
  return AppBar(
    scrolledUnderElevation: 0,
    title: Text(
      text,
      style: TextStyles.semibold30insturment.copyWith(
        color: AppColors.secondaryColor,
      ),
    ),
    centerTitle: true,
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
  );
}

PreferredSize paddingAppbar({context, required String text}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 16),
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        child: buildAppBar(text: text, context: context),
      ));
}

PreferredSize otpAppBar(BuildContext context) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 16),
      child: Container(
          padding: const EdgeInsets.only(top: 16),
          child: AppBar(
            scrolledUnderElevation: 0,
            title: Text(
              S.of(context).forgot_pass,
              style: TextStyles.semibold16inter.copyWith(),
            ),
            centerTitle: true,
            leading: GestureDetector(
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
          )));
}
