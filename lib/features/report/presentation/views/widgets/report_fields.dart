import 'package:civix_app/core/helper_functions/category_functions.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomDescriptionField extends StatelessWidget {
  const CustomDescriptionField({super.key, this.onSaved});
  final void Function(String?)? onSaved;
  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1.8,
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 300,
      maxLines: 4,
      textInputAction: TextInputAction.done,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).required_field;
        }
        return null;
      },
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        filled: true,
        // fillColor: const Color(0xFFF9FAFA),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        hintText: S.of(context).description,
        hintStyle: TextStyles.medium16inter.copyWith(
          color: AppColors.lightGrayColor,
        ),
      ),
    );
  }
}

class CustomTitleField extends StatelessWidget {
  const CustomTitleField({super.key, this.onSaved});
  final void Function(String?)? onSaved;
  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1.8,
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 50,
      textInputAction: TextInputAction.next,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).required_field;
        }
        return null;
      },
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        filled: true,
        // fillColor: const Color(0xFFF9FAFA),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        hintText: S.of(context).title,
        hintStyle: TextStyles.medium16inter.copyWith(
          color: AppColors.lightGrayColor,
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  final Function(String?) onSelected;

  const DropdownMenuExample({
    super.key,
    required this.onSelected,
  });

  @override
  _DropdownMenuExampleState createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? selectedValue;
  final List<String> items = [
    S.current.pothole,
    S.current.garbage,
    S.current.broken_streetlight,
    S.current.manhole,
    S.current.flooding,
    S.current.graffiti,
    S.current.other,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppColors.primaryColor, width: 2), // Border Styling
        // Background color
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.all(4),
          isExpanded: true,
          hint: Text(
            S.of(context).choose_a_category,
          ),
          icon:
              const Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
          value: selectedValue,
          iconSize: 32,
          elevation: 16,

          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              fontSize: 16),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
            // int categoryId = getCategoryId(newValue!);
            widget.onSelected(selectedValue);
          }, // Use widget.onChanged
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
