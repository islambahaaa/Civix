import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_app_bar.dart';
import 'package:civix_app/features/auth/domain/repos/auth_repo.dart';
import 'package:civix_app/features/auth/presentation/cubits/send_otp_cubit/cubit/send_otp_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/otp_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpView extends StatelessWidget {
  final String email;
  const OtpView({super.key, required this.email});
  static const String routeName = 'otp';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SendOtpCubit(
                  getIt.get<AuthRepo>(),
                )),
      ],
      child: Scaffold(
        appBar: otpAppBar(context),
        body: OtpViewBody(
          email: email,
        ),
      ),
    );
  }
}
