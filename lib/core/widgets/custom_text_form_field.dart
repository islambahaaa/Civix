import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.suffixIcon,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.isEmailform = false,
    this.controller,
    this.isDone = false,
    this.focusNode,
  });
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool isEmailform;
  final bool isDone;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      textInputAction: TextInputAction.next,
      obscureText: obscureText,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This Field is required';
        } else if (isEmailform) {
          if (!EmailValidator.validate(value)) {
            return 'Enter a valid email';
          }
        }
        return null;
      },
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.secondaryColor,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        border: buildBorder(isDone: isDone),
        enabledBorder: buildBorder(isDone: isDone),
        focusedBorder: buildBorder(),
        hintText: hintText,
        hintStyle: TextStyles.medium16inter.copyWith(
          color: AppColors.lightGrayColor,
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder({bool isDone = false}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: isDone ? AppColors.secondaryColor : const Color(0xFFE6E9E9),
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }
}

class CustomChangeBorderTextField extends StatefulWidget {
  const CustomChangeBorderTextField({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.isEmailform = false,
  });
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final bool obscureText;
  final bool isEmailform;
  @override
  State<CustomChangeBorderTextField> createState() =>
      _CustomChangeBorderTextFieldState();
}

class _CustomChangeBorderTextFieldState
    extends State<CustomChangeBorderTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    // Listen to focus changes
    _focusNode.addListener(() {
      setState(() {
        _isDone = !_focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the focus node
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      isEmailform: widget.isEmailform,
      suffixIcon: widget.suffixIcon,
      prefixIcon: widget.prefixIcon,
      controller: widget.controller,
      obscureText: widget.obscureText,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      hintText: widget.hintText,
      textInputType: widget.textInputType,
      focusNode: _focusNode,
      isDone: _isDone,
    );
  }
}

class CustomDescriptionField extends StatelessWidget {
  const CustomDescriptionField({super.key, this.onSaved});
  final void Function(String?)? onSaved;
  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1.8,
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 300,
      maxLines: 5,
      textInputAction: TextInputAction.done,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This Field is required';
        }
        return null;
      },
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        hintText: 'Description',
        hintStyle: TextStyles.medium16inter.copyWith(
          color: AppColors.lightGrayColor,
        ),
      ),
    );
  }
}
