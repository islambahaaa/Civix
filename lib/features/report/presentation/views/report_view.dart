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