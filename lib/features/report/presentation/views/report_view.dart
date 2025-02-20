import 'dart:io';

import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/custom_text_form_field.dart';
import 'package:civix_app/features/report/presentation/views/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});
  static const routeName = '/report';

  @override
  Widget build(BuildContext context) {
    List<XFile>? imagesList;
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
            MultiImagePickerScreen(
              onImagePicked: (images) {
                imagesList = images;
              },
            ),
            const SizedBox(height: 20),
            const DropdownMenuExample(),
            const SizedBox(
              height: 20,
            ),
            const CustomTitleField(),
            const SizedBox(
              height: 12,
            ),
            const CustomDescriptionField(),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
                onPressed: () async {
                  // bool serviceEnabled;
                  // LocationPermission permission;
                  // if (!await Geolocator.isLocationServiceEnabled()) {
                  //   print("GPS is disabled. Opening location settings...");
                  //   await Geolocator.openLocationSettings();
                  //   return;
                  // }
                  // await Geolocator.checkPermission();
                  // permission = await Geolocator.requestPermission();
                  // if (permission == LocationPermission.denied) {
                  //   buildSnackBar(context, 'Location permissions are denied');
                  //   return;
                  // }

                  // try {
                  //   const locationSettings = LocationSettings(
                  //     accuracy: LocationAccuracy.high,
                  //     distanceFilter: 100,
                  //   );
                  //   Position position = await Geolocator.getCurrentPosition(
                  //       locationSettings: locationSettings);
                  //   print(position);
                  // } on PlatformException catch (e) {
                  //   buildSnackBar(context, 'Please provide location');
                  //   return;
                  // }
                  await checkAndGetLocation(context);
                  // if (await Gal.requestAccess()) {
                  //   if (imagesList != null) {
                  //     for (var image in imagesList!) {
                  //       await Gal.putImage(image.path, album: 'Civix');
                  //     }
                  //     return;
                  //   }
                  //   buildSnackBar(context, 'Please provide images');
                  // } else {
                  //   buildSnackBar(context, 'Please give permission');
                  // }
                },
                text: 'Submit')
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

Future<void> getCurrentLocation(BuildContext context) async {
  LocationPermission permission;

  // Check if permission is granted
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle case when user denies permission
      print("Location permission denied");
      //showSnackBar("Location permission is required to access your location.");
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Handle case when user permanently denies permission
    print("Location permission permanently denied");
    //showSnackBar("Location permission is permanently denied. Please enable it in app settings.");
    await Geolocator.openAppSettings();
    return;
  }

  // Proceed to get location
  try {
    Position position = await Geolocator.getCurrentPosition();
    buildSnackBar(context,
        'Location fetched: ${position.latitude}, ${position.longitude}');
  } catch (e) {
    print("Error getting location: $e");
    //showSnackBar("Failed to fetch location. Please try again.");
  }
}

Future<void> checkAndGetLocation(BuildContext context) async {
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationServiceEnabled) {
    print("GPS is disabled. Prompting user to enable it.");
    //showSnackBar("GPS is disabled. Please enable it to fetch your location.");
    await Geolocator.openLocationSettings();
    return;
  }

  // If GPS is enabled, proceed to get location
  await getCurrentLocation(context);
}

//