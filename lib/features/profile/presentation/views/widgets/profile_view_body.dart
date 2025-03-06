import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/profile_list_tile.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/profile_section.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/switch_widget.dart';
import 'package:civix_app/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    bool isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;
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
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.secondary
                          : AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            ProfileSection(children: [
              const ProfileListTile(
                icon: Icons.language_outlined,
                text: 'Language',
              ),
              GestureDetector(
                  onTap: () {
                    _showThemeDialog(context);
                  },
                  child: const ProfileListTile(
                    icon: Icons.dark_mode_outlined,
                    text: 'Theme',
                  )),
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
            ProfileSection(children: [
              GestureDetector(
                  onTap: () {
                    showAreYouSureDialog(context, () {
                      BlocProvider.of<UserCubit>(context).logout();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          SigninView.routeName, (route) => false);
                    });
                  },
                  child: const ProfileListTile(
                      icon: Icons.logout_outlined, text: 'Logout'))
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

void _showThemeDialog(BuildContext context) {
  final cubit = context.read<ThemeCubit>();
  ThemeMode currentMode = cubit.state; // Get current theme

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text("Select Theme"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRadioTile(
                context, "System Default", ThemeMode.system, currentMode),
            _buildRadioTile(
                context, "Light Mode", ThemeMode.light, currentMode),
            _buildRadioTile(context, "Dark Mode", ThemeMode.dark, currentMode),
          ],
        ),
      );
    },
  );
}

Widget _buildRadioTile(
    BuildContext context, String title, ThemeMode mode, ThemeMode currentMode) {
  return RadioListTile<ThemeMode>(
    activeColor: AppColors.primaryColor,
    title: Text(title),
    value: mode,
    groupValue: currentMode, // Checks the selected option
    onChanged: (newMode) {
      if (newMode == ThemeMode.system) {
        context.read<ThemeCubit>().followSystemTheme();
      } else if (newMode == ThemeMode.dark) {
        context.read<ThemeCubit>().toggleTheme(true);
      } else {
        context.read<ThemeCubit>().toggleTheme(false);
      }
      Navigator.pop(context); // Close the dialog
    },
  );
}
