import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:civix_app/constants.dart';
import 'package:civix_app/core/utils/app_images.dart';

import 'package:svg_flutter/svg_flutter.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.userEntity});
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: kVerticalPadding,
                ),
                CustomHomeAppBar(
                  fname: userEntity.fname,
                  lname: userEntity.lname,
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
