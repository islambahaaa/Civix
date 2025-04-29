import 'dart:ffi';

import 'package:civix_app/core/widgets/password_validator.dart';
import 'package:civix_app/features/auth/presentation/views/otp_view.dart';
import 'package:civix_app/generated/l10n.dart';
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
  final TextEditingController passwordController = TextEditingController();

  late String email, password, confirmpass, fname, lname, phoneNumber;
  late bool isTermsAccepted = false;
  late bool isPasswordValid;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SingleChildScrollView(
          reverse: true,
          child: AutofillGroup(
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: Column(children: [
                const SizedBox(
                  height: 24,
                ),
                Row(children: [
                  Flexible(
                    child: CustomChangeBorderTextField(
                      autofillHints: const [AutofillHints.givenName],
                      onSaved: (value) {
                        fname = value!.trim();
                      },
                      labelText: S.of(context).first_name,
                      hintText: 'e.g. John',
                      prefixIcon: Icons.person,
                      textInputType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: CustomChangeBorderTextField(
                        autofillHints: const [AutofillHints.familyName],
                        onSaved: (value) {
                          lname = value!.trim();
                        },
                        labelText: S.of(context).last_name,
                        hintText: 'e.g. Doe',
                        prefixIcon: Icons.person,
                        textInputType: TextInputType.name),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                CustomChangeBorderTextField(
                  autofillHints: const [AutofillHints.email],
                  onSaved: (value) {
                    email = value!.trim();
                  },
                  labelText: S.of(context).email,
                  hintText: 'e.g. user@example.com',
                  prefixIcon: Icons.email,
                  textInputType: TextInputType.emailAddress,
                  isEmailform: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomChangeBorderPhoneField(
                  onSaved: (value) {
                    phoneNumber = value!.trim();
                  },
                  prefixIcon: Icons.phone_android,
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 16,
                ),
                PasswordField(
                    controller: passwordController,
                    onchanged: (value) {
                      password = value!;
                    },
                    lablelText: S.of(context).password,
                    hintText: S.of(context).enter_your_password),
                const SizedBox(
                  height: 8,
                ),
                PasswordValidator(
                  controller: passwordController,
                  onFailure: (value) {
                    isPasswordValid = value;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                PasswordField(
                  onchanged: (value) {
                    confirmpass = value!;
                  },
                  lablelText: S.of(context).confirm_password,
                  hintText: S.of(context).re_enter_your_password,
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
                        if (isPasswordValid == false) {
                          buildSnackBar(context, S.of(context).weak_password);
                        } else if (password != confirmpass) {
                          buildSnackBar(
                              context, S.of(context).password_mismatch);
                        } else if (isTermsAccepted) {
                          context
                              .read<SignupCubit>()
                              .createUserWithEmailAndPassword(fname, lname,
                                  email, phoneNumber, password, confirmpass);
                        } else {
                          buildSnackBar(context, S.of(context).accept_terms);
                        }
                      } else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    text: S.of(context).signup),
                const SizedBox(
                  height: 26,
                ),
                const HaveAccountWidget(),
                const SizedBox(
                  height: 8,
                ),
              ]),
            ),
          )),
    );
  }
}
