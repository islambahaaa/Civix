import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
import 'package:civix_app/features/edit_profile/presentation/pages/edit_profile_page.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/language_dialog.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/profile_list_tile.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/profile_section.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/switch_widget.dart';
import 'package:civix_app/features/profile/presentation/views/widgets/theme_dialog.dart';
import 'package:civix_app/generated/l10n.dart';
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
                    child: Image.asset(Assets.imagesProfileImage,
                        width: 120, height: 120)),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is UserSuccess) {
                      return Text(
                        '${state.user.fname} ${state.user.lname}',
                        style: TextStyles.semibold24inter,
                      );
                    } else if (state is UserFailure) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(S.of(context).no_user_data));
                    }
                  },
                ),
              ]),
            ]),
            const SizedBox(
              height: 20,
            ),
            ProfileSection(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, EditProfileView.routeName);
                  },
                  child: ProfileListTile(
                      icon: Icons.notes_outlined,
                      text: S.of(context).edit_profile),
                ),
                ProfileListTile(
                  icon: Icons.notifications_outlined,
                  text: S.of(context).notifications,
                  trailing: const SwitchWidget(),
                ),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is UserSuccess) {
                      return ProfileListTile(
                        icon: Icons.phone_outlined,
                        text: S.of(context).mobile_number,
                        trailing: Text(
                          state.user.phoneNumber,
                          style: TextStyles.regular14inter.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Theme.of(context).colorScheme.secondary
                                    : AppColors.secondaryColor,
                          ),
                        ),
                      );
                    } else if (state is UserFailure) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(S.of(context).no_user_data));
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            ProfileSection(children: [
              GestureDetector(
                onTap: () {
                  showLanguageDialog(context);
                },
                child: ProfileListTile(
                  icon: Icons.language_outlined,
                  text: S.of(context).language,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    showThemeDialog(context);
                  },
                  child: ProfileListTile(
                    icon: Icons.dark_mode_outlined,
                    text: S.of(context).theme,
                  )),
            ]),
            const SizedBox(
              height: 25,
            ),
            ProfileSection(children: [
              ProfileListTile(
                icon: Icons.help_outline_outlined,
                text: S.of(context).help,
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
                  child: ProfileListTile(
                      icon: Icons.logout_outlined, text: S.of(context).logout))
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
