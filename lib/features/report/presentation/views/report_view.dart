import 'dart:io';

import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/custom_text_form_field.dart';
import 'package:civix_app/features/report/presentation/views/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});
  static const routeName = '/report';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightprimaryColor,
        centerTitle: true,
        title: const Text('Report'),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(children: [
            const MultiImagePickerScreen(),
            const SizedBox(height: 20),
            const DropdownMenuExample(),
            const SizedBox(
              height: 20,
            ),
            const CustomDescriptionField(),
            const SizedBox(
              height: 16,
            ),
            CustomButton(onPressed: () {}, text: 'Submit')
          ]),
        ),
      )),
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
    'Broken Road',
    'Street Light Problem',
    'Water Leak',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: AppColors.primaryColor, width: 2), // Border Styling
        color: Colors.white, // Background color
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.all(4),
          isExpanded: true,
          hint: const Text(
            "Select an option",
            style: TextStyle(color: Colors.grey),
          ),
          icon:
              const Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
          value: selectedValue,

          // Dropdown icon
          iconSize: 24,
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
