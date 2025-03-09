import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/widgets/custom_app_bar.dart';
import 'package:civix_app/features/auth/domain/repos/auth_repo.dart';
import 'package:civix_app/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/forgot_password_view_bloc_consumer.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/forgot_password_view_body.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});
  static const String routeName = 'forgot';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: paddingAppbar(
            text: S.of(context).forgot_password, context: context),
        body: const ForgotPasswordBlocConsumer(),
      ),
    );
  }
}
