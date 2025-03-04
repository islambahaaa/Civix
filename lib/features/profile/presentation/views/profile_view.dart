import 'package:civix_app/constants.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/logout_widget.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(children: [
                    Image.asset(Assets.imagesProfileImage),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('Islam Bahaa',
                        style: TextStyles.semibold24inter),
                  ]),
                ]),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ]),
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.notes_outlined),
                        title: Text('Edit Profile'),
                      ),
                      const ListTile(
                          leading: Icon(Icons.notifications_outlined),
                          title: Text('Notification '),
                          trailing: SwitchWidget()),
                      ListTile(
                        leading: const Icon(Icons.phone_outlined),
                        title: const Text('Mobile Number'),
                        trailing: Text(
                          '01090357957',
                          style: TextStyles.regular14inter.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ]),
                  child: const Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.language_outlined),
                        title: Text('Language'),
                      ),
                      ListTile(
                        leading: Icon(Icons.dark_mode_outlined),
                        title: Text('Theme'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ]),
                  child: const ListTile(
                    leading: Icon(Icons.help_outline_outlined),
                    title: Text('Help'),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ]),
                  child: const ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                    ),
                    title: Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
        activeColor: AppColors.primaryColor,
        splashRadius: 15,
        value: switchValue,
        onChanged: (value) {
          setState(() {
            switchValue = value;
          });
        });
  }
}
