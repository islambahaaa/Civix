import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueMapLocation extends StatelessWidget {
  const IssueMapLocation({super.key, required this.location});
  static const String routeName = "IssueMapLocation";
  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Issue Location")),
      body: LocationDetailsGoogleMap(location: location),
    );
  }
}

class LocationDetailsGoogleMap extends StatelessWidget {
  const LocationDetailsGoogleMap({
    super.key,
    required this.location,
  });

  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: location,
        zoom: 14,
      ),
      markers: {
        Marker(
          markerId: const MarkerId("itemLocation"),
          position: location,
        ),
      },
    );
  }
}
