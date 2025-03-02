import 'dart:io';

import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/custom_text_form_field.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/widgets/image_picker_widget.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_fields.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_view_bloc_consumer.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});
  static const routeName = '/report';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightprimaryColor,
          centerTitle: true,
          title: const Text('Report'),
        ),
        body: const ReportViewBodyBlocConsumer(),
      ),
    );
  }
}
// }

// Future<void> getCurrentLocation(BuildContext context) async {
//   LocationPermission permission;

//   // Check if permission is granted
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       buildSnackBar(
//           context, "Location permission is required to access your location.");
//       return;
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     buildSnackBar(context,
//         "Location permission is permanently denied. Please enable it in app settings.");
//     await Geolocator.openAppSettings();
//     return;
//   }

//   // Proceed to get location
//   try {
//     Position position = await Geolocator.getCurrentPosition();
//     BuildContext rootContext =
//         Navigator.of(context, rootNavigator: true).context;

//     Navigator.of(context).pop(); // Close the current screen

//     Future.delayed(const Duration(milliseconds: 300), () {
//       showCustomDialog(rootContext,
//           'Report submitted successfully.\n \nLocation: ${position.latitude}, ${position.longitude}');

//       Future.delayed(const Duration(seconds: 2), () {
//         if (rootContext.mounted) {
//           Navigator.of(rootContext).pop(); // Close the dialog
//         }
//       });
//     });
//     // Close the current screen
//   } catch (e) {
//     buildSnackBar(context, "Failed to fetch location. Please try again.");
//   }
// }

// Future<void> checkAndGetLocation(BuildContext context) async {
//   bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!isLocationServiceEnabled) {
//     buildSnackBar(
//         context, 'GPS is disabled. Please enable it to fetch your location.');
//     Future.delayed(const Duration(seconds: 1));
//     await Geolocator.openLocationSettings();
//     return;
//   }

//   // If GPS is enabled, proceed to get location
//   await getCurrentLocation(context);
// }

// //