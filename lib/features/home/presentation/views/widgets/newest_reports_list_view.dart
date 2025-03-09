import 'package:civix_app/features/report/data/models/report_model.dart';
import 'package:civix_app/features/home/presentation/views/widgets/report_item.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class NewestReportsListView extends StatelessWidget {
  const NewestReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ReportModel> reports = [
      ReportModel(
          id: '1',
          title: S.of(context).pothole_example,
          description: 'description',
          imageUrl: 'imageUrl',
          location: 'location',
          date: S.of(context).date_example,
          city: S.of(context).giza,
          status: S.of(context).solved),
      ReportModel(
        id: '2',
        title: S.of(context).street_light,
        description: 'description',
        imageUrl: 'imageUrl',
        location: 'location',
        date: S.of(context).date_example_2,
        city: S.of(context).new_cairo,
        status: S.of(context).in_progress,
      ),
      ReportModel(
        id: '3',
        title: S.of(context).graffiti,
        description: 'description',
        imageUrl: 'imageUrl',
        location: 'location',
        date: S.of(context).date_example_3,
        city: S.of(context).alexandria,
        status: S.of(context).denied,
      ),
      ReportModel(
        id: '4',
        title: S.of(context).water_leak,
        description: 'description',
        imageUrl: 'imageUrl',
        location: 'location',
        date: S.of(context).date_example_3,
        city: S.of(context).maadi,
        status: S.of(context).solved,
      ),
      ReportModel(
          id: '5',
          title: S.of(context).broken_street,
          description: 'description',
          imageUrl: 'imageUrl',
          location: 'location',
          date: S.of(context).date_example_3,
          city: S.of(context).al_shorouk,
          status: S.of(context).in_progress),
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
