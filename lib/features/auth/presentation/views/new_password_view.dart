import 'package:civix_app/core/widgets/custom_app_bar.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/new_password_view_body.dart';
import 'package:flutter/material.dart';

class NewPasswordView extends StatelessWidget {
  final UserEntity userEntity;
  const NewPasswordView({super.key, required this.userEntity});
  static const routeName = 'new-password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: otpAppBar(context),
      body: const NewPasswordViewBody(),
    );
  }
}
