import 'dart:io';

import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/custom_text_form_field.dart';
import 'package:civix_app/features/report/presentation/views/widgets/image_picker_widget.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_fields.dart';
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
                print(imagesList);
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
                  if (await Gal.requestAccess()) {
                    if (imagesList != null) {
                      print("hello this is $imagesList");
                      for (var image in imagesList!) {
                        await Gal.putImage(image.path, album: 'Civix');
                      }
                    } else {
                      buildSnackBar(context, 'Please provide images');
                      return;
                    }
                  } else {
                    buildSnackBar(context, 'Please give permission');
                    return;
                  }
                  await checkAndGetLocation(context);
                },
                text: 'Submit')
          ]),
        ),
      )),
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
      buildSnackBar(
          context, "Location permission is required to access your location.");
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    buildSnackBar(context,
        "Location permission is permanently denied. Please enable it in app settings.");
    await Geolocator.openAppSettings();
    return;
  }

  // Proceed to get location
  try {
    Position position = await Geolocator.getCurrentPosition();
    buildSnackBar(context,
        'Location fetched: ${position.latitude}, ${position.longitude}');
  } catch (e) {
    buildSnackBar(context, "Failed to fetch location. Please try again.");
  }
}

Future<void> checkAndGetLocation(BuildContext context) async {
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationServiceEnabled) {
    buildSnackBar(
        context, 'GPS is disabled. Please enable it to fetch your location.');
    Future.delayed(const Duration(seconds: 2));
    await Geolocator.openLocationSettings();
    return;
  }

  // If GPS is enabled, proceed to get location
  await getCurrentLocation(context);
}

//