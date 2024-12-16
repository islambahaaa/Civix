import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../utils/app_images.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAreYouSureDialog(context, () {
          BlocProvider.of<UserCubit>(context).logout();
          Navigator.of(context)
              .pushNamedAndRemoveUntil(SigninView.routeName, (route) => false);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.lightprimaryColor2,
        ),
        child: SvgPicture.asset(Assets.imagesLogout),
      ),
    );
  }
}

Future<void> showConfirmDialog(BuildContext context) async {
  bool? result = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you really want to perform this action?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Return false
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Return true
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );

  // Handle the result after dialog is dismissed
  if (result == true) {
    // User confirmed the action
    print('Action confirmed!');
  } else {
    // User canceled the action
    print('Action canceled!');
  }
}
