import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.isEnabled,
    required this.textInputType,
    this.autofillhints,
    this.suffixIcon,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.isEmailform = false,
    this.controller,
    this.isDone = false,
    this.focusNode,
    this.labelText,
  });
  final String? hintText;
  final String? labelText;
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
  final Iterable<String>? autofillhints;
  final bool? isEnabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      autofillHints: autofillhints,
      focusNode: focusNode,
      controller: controller,
      textInputAction: TextInputAction.next,
      obscureText: obscureText,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).required_field;
        } else if (isEmailform) {
          if (!EmailValidator.validate(value)) {
            return S.of(context).valid_email;
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
        fillColor: Theme.of(context).brightness == Brightness.light
            ? const Color(0xFFF9FAFA)
            : Colors.transparent,
        border: buildBorder(isDone: isDone),
        enabledBorder: buildBorder(isDone: isDone),
        focusedBorder: buildBorder(),
        labelText: labelText,
        labelStyle: TextStyles.medium16inter.copyWith(
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
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
    this.hintText,
    this.isEnabled,
    required this.textInputType,
    this.autofillHints,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.onSaved,
    this.onChanged,
    this.obscureText = false,
    this.isEmailform = false,
  });
  final String? hintText;
  final String? labelText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final bool obscureText;
  final bool isEmailform;
  final Iterable<String>? autofillHints;
  final bool? isEnabled;

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
      isEnabled: widget.isEnabled,
      autofillhints: widget.autofillHints,
      isEmailform: widget.isEmailform,
      suffixIcon: widget.suffixIcon,
      prefixIcon: widget.prefixIcon,
      controller: widget.controller,
      obscureText: widget.obscureText,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      hintText: widget.hintText,
      labelText: widget.labelText,
      textInputType: widget.textInputType,
      focusNode: _focusNode,
      isDone: _isDone,
    );
  }
}

class CustomChangeBorderPhoneField extends StatefulWidget {
  const CustomChangeBorderPhoneField({
    super.key,
    required this.textInputType,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.onSaved,
    this.onChanged,
  });
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  @override
  State<CustomChangeBorderPhoneField> createState() =>
      _CustomChangeBorderPhoneFieldState();
}

class _CustomChangeBorderPhoneFieldState
    extends State<CustomChangeBorderPhoneField> {
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
    final phoneRegex = RegExp(r'^01[0-2,5][0-9]{8}$');
    return TextFormField(
      autofillHints: const [AutofillHints.telephoneNumber],
      focusNode: _focusNode,
      controller: widget.controller,
      textInputAction: TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // allows only numbers
        LengthLimitingTextInputFormatter(11), // max 11 digits (for phone)
      ],
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).required_field;
        } else if (!phoneRegex.hasMatch(value)) {
          return S.of(context).egyptian_phone_number;
        }
        return null;
      },
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon,
          color: AppColors.secondaryColor,
        ),
        suffixIcon: widget.suffixIcon,
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.light
            ? const Color(0xFFF9FAFA)
            : Colors.transparent,
        border: buildBorder(isDone: _isDone),
        enabledBorder: buildBorder(isDone: _isDone),
        focusedBorder: buildBorder(),
        labelText: S.of(context).phone_number,
        labelStyle: TextStyles.medium16inter.copyWith(
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        hintText: '01xxxxxxxxx',
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
