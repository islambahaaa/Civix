import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gal/gal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  final List<XFile> images = [];

  Future<void> addImages(List<XFile> pickedImages) async {
    images.addAll(pickedImages);
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission;

    // Check if permission is granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(ReportFailure(
            'Location permission is required to access your location.'));

        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(ReportFailure(
          'Location permission is required to access your location.'));

      await Geolocator.openAppSettings();
      return;
    }

    // Proceed to get location
    try {
      Position position = await Geolocator.getCurrentPosition();
      emit(ReportSuccess());
    } catch (e) {
      emit(ReportFailure('Failed to fetch location: $e'));
    }
  }

  Future<void> checkAndGetLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      emit(ReportFailure(
          'GPS is disabled. Please enable it to fetch your location.'));
      Future.delayed(const Duration(seconds: 1));
      await Geolocator.openLocationSettings();
      return;
    }

    // If GPS is enabled, proceed to get location
    await getCurrentLocation();
  }

//
  Future<void> submitReport() async {
    if (await Gal.requestAccess()) {
      if (images.isNotEmpty) {
        for (var image in images) {
          emit(ReportLoading());
          await Gal.putImage(image.path, album: 'Civix');
        }
      } else {
        emit(ReportFailure('Please provide images'));

        return;
      }
    } else {
      emit(ReportFailure('Gallery permission denied'));
      return;
    }
    emit(ReportLoading());
    await checkAndGetLocation();
  }

  // Future<bool> isDuplicate(XFile newFile) async {
  //   List<int> newBytes = await File(newFile.path).readAsBytes();
  //   String newHash = base64Encode(newBytes);

  //   for (XFile existingFile in _images) {
  //     List<int> existingBytes = await File(existingFile.path).readAsBytes();
  //     String existingHash = base64Encode(existingBytes);

  //     if (existingHash == newHash) return true;
  //   }
  //   return false;
  // }

  // Future<bool> requestCameraPermission() async {
  //   var status = await Permission.camera.request();
  //   return status.isGranted;
  // }

  // Future<bool> requestGalleryPermission() async {
  //   var status = await Permission.photos.request();
  //   return status.isGranted;
  // }

  // Future<void> pickImagesFromGallery() async {
  //   try {
  //     final List<XFile> selectedImages = await _picker.pickMultiImage();
  //     if (selectedImages.isNotEmpty) {
  //       for (var image in selectedImages) {
  //         final File file = File(image.path);
  //         final int fileSizeInBytes = await file.length();
  //         if (await isDuplicate(image)) {
  //           emit(ReportFailure('You have already selected this image.'));

  //           continue;
  //         }
  //         if (fileSizeInBytes > maxImageSizeInBytes) {
  //           emit(ReportFailure('Image "${image.name}" exceeds 5 MB'));
  //           continue; // Skip this image
  //         }

  //         if (_images.length < maxImages) {
  //           _images.add(image);
  //           emit(ReportImagesSuccess(_images));
  //         } else {
  //           emit(ReportFailure('Maximum number of images reached'));
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     emit(ReportFailure('Failed to pick images: $e'));
  //   }
  // }

  // Future<void> pickImagesFromCamera() async {
  //   if (await requestCameraPermission()) {
  //     try {
  //       final XFile? selectedImage =
  //           await _picker.pickImage(source: ImageSource.camera);
  //       if (selectedImage != null) {
  //         if (_images.length < maxImages) {
  //           _images.add(selectedImage);
  //           emit(ReportImagesSuccess(_images));
  //         } else {
  //           emit(ReportFailure('Maximum number of images reached'));
  //         }
  //       }
  //     } catch (e) {
  //       emit(ReportFailure('Failed to pick images: $e'));
  //     }
  //   } else {
  //     emit(ReportFailure('Camera permission denied'));
  //   }
  // }
}
