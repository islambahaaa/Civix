import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
    this.onchanged,
    this.hintText = 'Password',
    this.controller,
  });
  final void Function(String?)? onSaved;
  final void Function(String?)? onchanged;
  final TextEditingController? controller;
  final String hintText;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomChangeBorderTextField(
      controller: widget.controller,
      obscureText: obscureText,
      onSaved: widget.onSaved,
      onChanged: widget.onchanged,
      hintText: widget.hintText,
      textInputType: TextInputType.visiblePassword,
      prefixIcon: Icons.lock,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: obscureText
            ? const Icon(
                Icons.remove_red_eye,
                color: Color(0xffC9CECF),
              )
            : const Icon(
                Icons.visibility_off,
                color: Color(0xffC9CECF),
              ),
      ),
    );
  }
}
