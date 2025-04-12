import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/widgets/custom_progress_hud.dart';
import 'package:civix_app/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/sign_up_view_body.dart';

class SignUpBodyBlocConsumer extends StatelessWidget {
  const SignUpBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          BuildContext rootContext =
              Navigator.of(context, rootNavigator: true).context;

          Navigator.of(context).pop(); // Close the current screen

          Future.delayed(const Duration(milliseconds: 300), () {
            showCustomDialog(rootContext, S.current.verifyEmailTitle,
                S.current.verifyEmailMessage, Icons.email);
          });

          // buildSnackBar(context, S.of(context).success);
        }
        if (state is SignupFailure) {
          buildSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SignupLoading,
          child: const SignUpViewBody(),
        );
      },
    );
  }
}
