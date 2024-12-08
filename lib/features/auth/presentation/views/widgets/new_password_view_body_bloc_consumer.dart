import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/core/widgets/custom_progress_hud.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/cubits/new_password/new_password_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/forgot_password_view_body.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/new_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordViewBodyBlocConsumer extends StatelessWidget {
  const NewPasswordViewBodyBlocConsumer({
    super.key,
    required this.userEntity,
  });
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewPasswordCubit, NewPasswordState>(
      listener: (context, state) {
        if (state is NewPasswordSuccess) {
          showCongratulationsDialog(context);
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          });
        }
        if (state is NewPasswordFailure) {
          buildSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is NewPasswordLoading,
          child: NewPasswordViewBody(
            user: userEntity,
          ),
        );
      },
    );
  }
}
