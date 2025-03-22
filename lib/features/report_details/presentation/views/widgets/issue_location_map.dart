import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueMapLocation extends StatefulWidget {
  const IssueMapLocation({super.key, required this.location});
  final LatLng location;
  @override
  State<IssueMapLocation> createState() => _IssueMapLocationState();
}

late GoogleMapController _mapController;

class _IssueMapLocationState extends State<IssueMapLocation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.location,
            zoom: 14,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("itemLocation"),
              position: widget.location,
            ),
          },
          onMapCreated: (controller) {
            _mapController = controller;
          },
        ),
      ),
    );
  }
}
