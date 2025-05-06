import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/custom_text_form_field.dart';
import 'package:civix_app/features/auth/data/models/user_model.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/new_password_view.dart';
import 'package:civix_app/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:civix_app/features/home/presentation/views/widgets/pick_location_widget.dart';
import 'package:civix_app/features/pickmyarea/presentation/views/pick_my_area_view.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody(
      {super.key, required this.user, required this.token});
  final UserEntity user;
  final String token;
  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  // Controllers
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late String fname, lname, phoneNumber, area;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    area = widget.user.area ?? 'Select your area';
    _emailController.text = widget.user.email;
    _firstNameController.text = widget.user.fname;
    _lastNameController.text = widget.user.lname;
    _phoneController.text = widget.user.phoneNumber;
  }

  bool _hasChanges() {
    return _firstNameController.text != widget.user.fname ||
        _lastNameController.text != widget.user.lname ||
        _phoneController.text != widget.user.phoneNumber ||
        area != widget.user.area;
  }

  Future<void> saveFields() async {
    fname = _firstNameController.text.trim();
    lname = _lastNameController.text.trim();
    phoneNumber = _phoneController.text.trim();
  }

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
                CustomChangeBorderTextField(
                  isEnabled: false,
                  controller: _emailController,
                  autofillHints: const [AutofillHints.email],
                  labelText: S.of(context).email,
                  hintText: 'e.g. user@example.com',
                  prefixIcon: Icons.email,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Flexible(
                    child: CustomChangeBorderTextField(
                      controller: _firstNameController,
                      autofillHints: const [AutofillHints.givenName],
                      labelText: S.of(context).first_name,
                      hintText: 'e.g. John',
                      prefixIcon: Icons.person,
                      textInputType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: CustomChangeBorderTextField(
                        controller: _lastNameController,
                        autofillHints: const [AutofillHints.familyName],
                        labelText: S.of(context).last_name,
                        hintText: 'e.g. Doe',
                        prefixIcon: Icons.person,
                        textInputType: TextInputType.name),
                  ),
                ]),
                const SizedBox(
                  height: 16,
                ),
                CustomChangeBorderPhoneField(
                  controller: _phoneController,
                  onSaved: (value) {
                    phoneNumber = value!.trim();
                  },
                  prefixIcon: Icons.phone_android,
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PickMyAreaView()),
                    );

                    if (result != null && context.mounted) {
                      setState(() {
                        area = result;
                      });
                    }
                  },
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.location_on,
                          ),
                        ),
                        Text(area),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: CustomButton(
                    color: AppColors.secondaryColor,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => NewPasswordView(
                                    email: widget.user.email,
                                    token: widget.token,
                                  )));
                    },
                    text: 'Change Password',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (!_hasChanges()) {
                          buildSnackBar(context, 'No changes');
                          return;
                        }
                        if (area == 'Select your area') {
                          buildSnackBar(context, 'Select your area');
                          return;
                        }
                        formKey.currentState!.save();
                        saveFields();
                        BlocProvider.of<UserCubit>(context).saveUser(
                            widget.user.email, fname, lname, phoneNumber, area);
                        BlocProvider.of<EditProfileCubit>(context)
                            .editCurrentUser(widget.user.email, fname, lname,
                                phoneNumber, area);
                      } else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    text: 'Save'),
              ]),
            ),
          )),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
