import 'package:civix_app/features/report/data/models/report_model.dart';
import 'package:civix_app/features/home/presentation/views/widgets/custom_report_image.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ReportDetailsView extends StatelessWidget {
  const ReportDetailsView({super.key, required this.report});

  static const routeName = '/report_details';
  final ReportModel report;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).report_details),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.2),
            child: Hero(
              tag: 'imageHero${report.id}',
              child: CustomReportImage(
                borderRadius: BorderRadius.circular(8),
                imageUrl: 'https://picsum.photos/200',
              ),
            ),
          ),
          const SizedBox(height: 23),
          Text(
            report.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            report.description,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
