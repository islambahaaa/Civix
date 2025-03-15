import 'dart:developer';

import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  _MapPickerScreenState createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late GoogleMapController _mapController;
  LatLng _currentPosition = const LatLng(30.0444, 31.2357); // Default position
  double _currentZoom = 14.0;
  final double _zoomThreshold = 17.0;

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _currentPosition = position.target;
      _currentZoom = position.zoom;
    });
  }

  void _onButtonPressed() {
    if (_currentZoom < _zoomThreshold) {
      _mapController.animateCamera(
        CameraUpdate.zoomTo(_zoomThreshold),
      );
    } else {
      _pickLocation();
    }
  }

  void _pickLocation() {
    log("Picked Location: $_currentPosition");
    double lat = _currentPosition.latitude;
    double long = _currentPosition.longitude;
    BlocProvider.of<ReportCubit>(context).submitReportFromGallery(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: _currentZoom,
          ),
          onMapCreated: (controller) => _mapController = controller,
          onCameraMove: _onCameraMove,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
        ),
        const Positioned(
          top: -50,
          bottom: -5,
          child: Icon(
            Icons.location_on,
            size: 50,
            color: Colors.red,
          ),
        ),
        Positioned(
          bottom: 25,
          left: 25,
          right: 25,
          child: SizedBox(
            height: 70,
            child: CustomButton(
              text: _currentZoom < _zoomThreshold
                  ? 'Zoom In to Select Location'
                  : 'Pick Location',
              onPressed: _onButtonPressed,
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          right: 20,
          child: FloatingActionButton(
            onPressed: () async {
              LocationPermission permission =
                  await Geolocator.requestPermission();
              if (permission == LocationPermission.denied ||
                  permission == LocationPermission.deniedForever) {
                // Handle permission denied
                return;
              }

              final position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
              );

              _mapController.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(position.latitude, position.longitude),
                ),
              );
            },
            backgroundColor: Theme.of(context).cardColor,
            child: const Icon(
              Icons.my_location,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
