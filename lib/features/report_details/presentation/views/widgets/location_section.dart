import 'package:civix_app/features/report_details/presentation/views/widgets/issue_location_map.dart';
import 'package:civix_app/features/report_details/presentation/views/widgets/location_details_container.dart';
import 'package:civix_app/features/report_details/presentation/views/widgets/location_item.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSection extends StatelessWidget {
  const LocationSection(
      {super.key, required this.location, required this.address});
  final LatLng location;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text("Location",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        LocationWidget(text: address),
        const SizedBox(
          height: 16,
        ),
        IssueLocationContainer(location: location),
      ],
    );
  }
}
