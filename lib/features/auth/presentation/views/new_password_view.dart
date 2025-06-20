import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/widgets/custom_app_bar.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/domain/repos/auth_repo.dart';
import 'package:civix_app/features/auth/presentation/cubits/new_password/new_password_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/new_password_view_body_bloc_consumer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordView extends StatelessWidget {
  final String email;
  final String token;
  const NewPasswordView({super.key, required this.email, required this.token});
  static const routeName = 'new-password';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewPasswordCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
          appBar: AppBar(),
          body: NewPasswordViewBodyBlocConsumer(
            email: email,
            token: token,
          )),
    );
  }
}
