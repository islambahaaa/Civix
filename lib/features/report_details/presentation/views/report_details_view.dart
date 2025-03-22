import 'package:civix_app/features/home/data/models/report_model.dart';
import 'package:civix_app/features/report_details/presentation/views/widgets/description_section.dart';
import 'package:civix_app/features/report_details/presentation/views/widgets/image_slider.dart';
import 'package:civix_app/features/report_details/presentation/views/widgets/location_section.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportDetailsView extends StatelessWidget {
  const ReportDetailsView({super.key, required this.report});

  static const routeName = '/report_details';
  final ReportModel report;
  @override
  Widget build(BuildContext context) {
    final LatLng location = LatLng(report.lat, report.long);
    return Scaffold(
      appBar: AppBar(title: const Text('Issue Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image Slider
            ImageSlider(images: report.images),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(report.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 8),

                  /// Description

                  const SizedBox(height: 12),

                  /// Status
                  Row(
                    children: [
                      const Icon(Icons.info, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(report.status, style: const TextStyle(fontSize: 16)),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Date & Time
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(report.date, style: const TextStyle(fontSize: 16)),
                      const Spacer(),
                      const Text('12:00 AM', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(thickness: 0.25, color: Colors.grey),
                  DescriptionSection(description: report.description),
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
