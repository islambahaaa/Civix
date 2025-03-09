import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/core/repos/report_repo.dart';
import 'package:civix_app/core/services/api_report_service.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:gal/gal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit(this.reportRepo) : super(ReportInitial());
  ReportRepo reportRepo;
  final List<File> images = [];
  double? latitude;
  double? longitude;

  Future<void> addImages(List<XFile> pickedImages) async {
    images.clear();
    for (var image in pickedImages) {
      log(image.path);
      images.add(File(image.path));
    }
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission;

    // Check if permission is granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(ReportFailure(S.current.location_permission));

        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(ReportFailure(S.current.location_permission));

      await Geolocator.openAppSettings();
      return;
    }

    // Proceed to get location
    try {
      Position position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      emit(ReportFailure("${S.current.location_error}${e.toString()}"));
    }
  }

  Future<void> checkAndGetLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      emit(ReportFailure(S.current.gps_disabled));
      Future.delayed(const Duration(seconds: 1));
      await Geolocator.openLocationSettings();
      return;
    }

    // If GPS is enabled, proceed to get location
    await getCurrentLocation();
  }

//
  Future<void> submitReport(
    String title,
    String description,
    int category,
  ) async {
    if (await Gal.requestAccess()) {
      if (images.isNotEmpty) {
        for (var image in images) {
          emit(ReportLoading());
          await Gal.putImage(image.path, album: 'Civix');
        }
      } else {
        emit(ReportFailure(S.current.provide_images));

        return;
      }
    } else {
      emit(ReportFailure(S.current.gallery_denied));
      return;
    }
    await checkAndGetLocation();
    String token = await getToken();
    if (token.isEmpty) return;
    if (latitude == null || longitude == null) {
      emit(ReportFailure(S.current.location_fail));
      return;
    }
    await createIssue(
        title, description, latitude!, longitude!, category, images, token);
  }

  Future<String> getToken() async {
    try {
      String? user = await Prefs.getString(kUserData);
      if (user != null) {
        Map<String, dynamic> userMap = jsonDecode(user);
        return userMap['token'] ?? '';
      } else {
        emit(ReportFailure(S.current.login_first));
        return '';
      }
    } catch (e) {
      emit(ReportFailure("Failed to fetch user: ${e.toString()}"));
      return '';
    }
  }

  Future<void> createIssue(
      String title,
      String description,
      double latitude,
      double longitude,
      int category,
      List<File> imageFiles,
      String token) async {
    var result = await reportRepo.createReport(
        title, description, latitude, longitude, category, imageFiles, token);
    result.fold(
      (failure) => emit(ReportFailure(failure.message)),
      (s) => emit(ReportSuccess(s)),
    );
  }
}
