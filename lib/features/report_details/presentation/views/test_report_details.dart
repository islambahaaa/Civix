import 'package:civix_app/features/report_details/presentation/views/widgets/image_slider.dart';
import 'package:civix_app/features/report_details/presentation/views/widgets/location_section.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final String dateTime;
  final LatLng location;
  final List<String> images;

  const ItemDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.dateTime,
    required this.location,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image Slider
            ImageSlider(images: images),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 8),

                  /// Description
                  Text(description,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),

                  const SizedBox(height: 12),

                  /// Status
                  Row(
                    children: [
                      const Icon(Icons.info, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text("Status: $status",
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Date & Time
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(dateTime, style: const TextStyle(fontSize: 16)),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(thickness: 0.25, color: Colors.grey),

                  /// Location
                  LocationSection(location: location)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
