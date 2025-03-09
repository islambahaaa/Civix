import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/features/auth/domain/repos/auth_repo.dart';
import 'package:civix_app/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/signin_view_body_bloc_consumer.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});
  static const String routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        appBar: paddingAppbar(text: S.of(context).login),
        body: const SigninViewBodyBlocConsumer(),
      ),
    );
  }
}
