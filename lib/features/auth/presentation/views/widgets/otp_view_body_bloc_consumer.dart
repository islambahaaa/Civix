import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/widgets/custom_progress_hud.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/new_password_view.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/otp_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpViewBodyBlocConsumer extends StatelessWidget {
  const OtpViewBodyBlocConsumer({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is CheckOtpSuccess) {
          UserEntity userEntity = UserEntity(
            fname: "",
            lname: "",
            email: email,
            token: state.token,
          );
          Navigator.pushReplacementNamed(context, NewPasswordView.routeName,
              arguments: userEntity);
        }
        if (state is CheckOtpFailure) {
          buildSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is CheckOtpLoading,
          child: OtpViewBody(
            email: email,
          ),
        );
      },
    );
  }
}
