import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/custom_text_form_field.dart';
import 'package:civix_app/features/auth/presentation/views/new_password_view.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

// Mock data fetch
Future<Map<String, dynamic>> fetchUserProfile() async {
  await Future.delayed(const Duration(seconds: 2)); // simulate network delay
  return {
    "userName": "islam.bahaa",
    "email": "email@gmail.com",
    "firstName": "islam",
    "lastName": "bahaa",
    "phoneNumber": "01200887855",
  };
}

// Mock update function
Future<bool> updateUserProfile(Map<String, dynamic> data) async {
  await Future.delayed(const Duration(seconds: 1)); // simulate network delay
  return true; // simulate success
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  // Controllers
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late String email, fname, lname, phoneNumber;
  late Map<String, dynamic> _originalData;
  bool _isLoading = true;
  bool _isUpdating = false;
  String? _errorMessage;
  bool _showSuccessMessage = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final data = await fetchUserProfile();
      _userNameController.text = data['userName'] ?? '';
      _emailController.text = data['email'] ?? '';
      _firstNameController.text = data['firstName'] ?? '';
      _lastNameController.text = data['lastName'] ?? '';
      _phoneController.text = data['phoneNumber'] ?? '';
      _originalData = {
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'phoneNumber': _phoneController.text,
      };
    } catch (e) {
      setState(() => _errorMessage = 'Failed to load user data');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  bool _hasChanges() {
    return _firstNameController.text != _originalData['firstName'] ||
        _lastNameController.text != _originalData['lastName'] ||
        _phoneController.text != (_originalData['phoneNumber'] ?? '');
  }

  Future<void> _saveProfile() async {
    if (!formKey.currentState!.validate()) return;
    if (!_hasChanges()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No changes detected')),
      );
      return;
    }
    setState(() {
      _isUpdating = true;
      _showSuccessMessage = false;
    });

    final updatedData = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "phoneNumber": _phoneController.text.trim(),
    };

    final success = await updateUserProfile(updatedData);

    setState(() {
      _isUpdating = false;
      _showSuccessMessage = success;
    });
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
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NewPasswordView(
                                  email: email,
                                  token: '',
                                )));
                  },
                  child: const Text("Change Password"),
                ),
                const SizedBox(
                  height: 30,
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
