import 'package:civix_app/features/home/presentation/views/widgets/report_item.dart';
import 'package:flutter/material.dart';

class NewestReportsListView extends StatelessWidget {
  const NewestReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ReportItem(),
                SizedBox(
                  height: 7,
                ),
                Divider(
                  thickness: 0.15,
                ),
              ],
            ),
          );
        });
  }
}
