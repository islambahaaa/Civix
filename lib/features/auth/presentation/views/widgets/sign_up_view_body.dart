import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/custom_text_form_field.dart';
import 'package:civix_app/core/widgets/password_field.dart';
import 'package:civix_app/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/have_account_widget.dart';
import 'package:civix_app/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password, name;
  late bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SingleChildScrollView(
          child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(children: [
          const SizedBox(
            height: 24,
          ),
          CustomTextFormField(
              onSaved: (value) {
                name = value!;
              },
              hintText: 'الاسم كامل',
              textInputType: TextInputType.name),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            onSaved: (value) {
              email = value!;
            },
            hintText: 'البريد الإلكتروني',
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 16,
          ),
          PasswordField(
            onSaved: (value) {
              password = value!;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TermsAndConditions(
            onChange: (value) {
              isTermsAccepted = value;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  if (isTermsAccepted) {
                    context
                        .read<SignupCubit>()
                        .createUserWithEmailAndPassword(email, password, name);
                    buildSnackBar(context, 'تم التسجيل بنجاح');
                  } else {
                    buildSnackBar(context, 'الرجاء قبول الشروط والإحكام');
                  }
                } else {
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
              },
              text: 'إنشاء حساب جديد'),
          const SizedBox(
            height: 26,
          ),
          const HaveAccountWidget(),
        ]),
      )),
    );
  }
}
