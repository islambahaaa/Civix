import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/password_field.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/cubits/new_password/new_password_cubit.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg_flutter.dart';

class NewPasswordViewBody extends StatefulWidget {
  const NewPasswordViewBody(
      {super.key, required this.email, required this.token});
  final String email, token;
  @override
  State<NewPasswordViewBody> createState() => _NewPasswordViewBodyState();
}

class _NewPasswordViewBodyState extends State<NewPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String password, confirmpass;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                S.of(context).create_account,
                style: TextStyles.semibold28inter
                    .copyWith(color: AppColors.secondaryColor),
              ),
              const SizedBox(
                height: 29,
              ),
              PasswordField(
                onchanged: (value) {
                  password = value!;
                },
                hintText: S.of(context).password,
              ),
              const SizedBox(
                height: 16,
              ),
              PasswordField(
                hintText: S.of(context).confirm_password,
                onchanged: (value) {
                  confirmpass = value!;
                },
              ),
              const Spacer(),
              CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (password != confirmpass) {
                        buildSnackBar(context, S.of(context).password_mismatch);
                      } else {
                        context.read<NewPasswordCubit>().newPassword(
                            widget.token, widget.email, password, confirmpass);
                      }
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  text: S.of(context).verify),
            ],
          ),
        ),
      ),
    );
  }
}
