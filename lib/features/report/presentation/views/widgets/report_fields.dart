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
  final Function(int?) onSelected;

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
    'Pothole',
    'Garbage',
    'Broken Streetlight',
    'Manhole',
    'Flooding',
    'Grafitti',
    'Other'
  ];
  int _getCategoryId(String category) {
    switch (category) {
      case 'Pothole':
        return 1;
      case 'Broken Streetlight':
        return 2;
      case 'Garbage':
        return 3;
      case 'Manhole':
        return 4;
      case 'Grafitti':
        return 5;
      case 'Flooding':
        return 6;
      case 'Other':
        return 7;
      default:
        return 0; // Fallback value
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue, width: 2), // Border Styling
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
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          value: selectedValue,
          iconSize: 32,
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
            int categoryId = _getCategoryId(newValue!);
            widget.onSelected(categoryId);
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
