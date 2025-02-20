import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
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
      textInputAction: TextInputAction.next,
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
        hintText: 'Title',
        hintStyle: TextStyles.medium16inter.copyWith(
          color: AppColors.lightGrayColor,
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  _DropdownMenuExampleState createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? selectedValue; // Track the selected value
  final List<String> items = [
    'Pothole',
    'Garbage',
    'Broken Streetlight',
    'Manhole',
    'Flooding',
    'Grafitti',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppColors.primaryColor, width: 2), // Border Styling
        color: Colors.white, // Background color
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.all(4),
          isExpanded: true,
          hint: const Text(
            "Select Issue Type",
            style: TextStyle(color: Colors.grey),
          ),
          icon:
              const Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
          value: selectedValue,

          // Dropdown icon
          iconSize: 32,
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          // Remove the default underline
          // Make the dropdown take up available width
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue; // Update the selected value
            });
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            );
          }).toList(),
          // Background color of the dropdown menu
          // Maximum height of the dropdown menu
        ),
      ),
    );
  }
}
