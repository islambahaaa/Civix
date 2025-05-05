import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/custom_text_form_field.dart';
import 'package:civix_app/features/auth/data/models/user_model.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/views/new_password_view.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

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
  late String email, fname, lname, phoneNumber;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    _emailController.text = widget.user.email;
    _firstNameController.text = widget.user.fname;
    _lastNameController.text = widget.user.lname;
    _phoneController.text = widget.user.phoneNumber;
  }

  bool _hasChanges() {
    return _firstNameController.text != widget.user.fname ||
        _lastNameController.text != widget.user.lname ||
        _phoneController.text != widget.user.phoneNumber;
  }

  Future<void> _saveProfile() async {
    if (!formKey.currentState!.validate()) return;
    if (!_hasChanges()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No changes detected')),
      );
      return;
    }
    setState(() {});

    final updatedData = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "phoneNumber": _phoneController.text.trim(),
    };
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
                        formKey.currentState!.save();
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

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isEnabled = true,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        enabled: isEnabled,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Phone number is required';
    final phoneRegExp = RegExp(r'^\+?\d{7,15}$');
    if (!phoneRegExp.hasMatch(value)) return 'Enter a valid phone number';
    return null;
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
