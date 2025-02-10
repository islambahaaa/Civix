import 'package:civix_app/core/models/report_model.dart';
import 'package:civix_app/features/home/presentation/views/widgets/report_item.dart';
import 'package:flutter/material.dart';

class NewestReportsListView extends StatelessWidget {
  const NewestReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ReportModel> reports = [
      ReportModel(
          id: '1',
          title: 'a pothole in the main street',
          description: 'description',
          imageUrl: 'imageUrl',
          location: 'location',
          date: 'Jan 4,2022',
          city: 'Giza',
          status: 'Solved'),
      ReportModel(
          id: '2',
          title: 'street light problem',
          description: 'description',
          imageUrl: 'imageUrl',
          location: 'location',
          date: 'Feb 6,2023',
          city: 'New Cairo',
          status: 'In Progress'),
      ReportModel(
          id: '3',
          title: 'Graffiti on the wall',
          description: 'description',
          imageUrl: 'imageUrl',
          location: 'location',
          date: 'Jan 12,2024',
          city: 'Alexandria',
          status: 'Denied'),
      ReportModel(
          id: '4',
          title: 'Water leak',
          description: 'description',
          imageUrl: 'imageUrl',
          location: 'location',
          date: 'Mar 7,2025',
          city: 'Maadi',
          status: 'Solved'),
      ReportModel(
          id: '5',
          title: 'A broken Street',
          description: 'description',
          imageUrl: 'imageUrl',
          location: 'location',
          date: 'Dec 25,2025',
          city: 'Al Shorouk',
          status: 'In Progress'),
    ];
    return SliverList.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ReportItem(
                  report: reports[index],
                ),
                const SizedBox(
                  height: 7,
                ),
                const Divider(
                  thickness: 0.15,
                ),
              ],
            ),
          );
        });
  }
}
