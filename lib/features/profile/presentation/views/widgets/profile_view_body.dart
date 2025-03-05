import 'package:civix_app/constants.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/profile_list_tile.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/profile_section.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/switch_widget.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(Assets.imagesAvatar1,
                        width: 120, height: 120)),
                const SizedBox(
                  height: 16,
                ),
                const Text('Islam Bahaa', style: TextStyles.semibold24inter),
              ]),
            ]),
            const SizedBox(
              height: 20,
            ),
            ProfileSection(
              children: [
                const ProfileListTile(
                    icon: Icons.notes_outlined, text: 'Edit Profile'),
                const ProfileListTile(
                  icon: Icons.notifications_outlined,
                  text: 'Notification ',
                  trailing: SwitchWidget(),
                ),
                ProfileListTile(
                  icon: Icons.phone_outlined,
                  text: 'Mobile Number',
                  trailing: Text(
                    '01090357957',
                    style: TextStyles.regular14inter.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const ProfileSection(children: [
              ProfileListTile(
                icon: Icons.language_outlined,
                text: 'Language',
              ),
              ProfileListTile(
                icon: Icons.dark_mode_outlined,
                text: 'Theme',
              ),
            ]),
            const SizedBox(
              height: 25,
            ),
            const ProfileSection(children: [
              ProfileListTile(
                icon: Icons.help_outline_outlined,
                text: 'Help',
              )
            ]),
            const SizedBox(
              height: 25,
            ),
            const ProfileSection(children: [
              ProfileListTile(icon: Icons.logout_outlined, text: 'Logout')
            ]),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
