import 'package:civix_app/core/models/report_model.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/home/presentation/views/widgets/custom_report_image.dart';
import 'package:flutter/material.dart';

class ReportItem extends StatelessWidget {
  const ReportItem({super.key, required this.report});
  final ReportModel report;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            CustomReportImage(
                borderRadius: BorderRadius.circular(12),
                imageUrl: 'https://picsum.photos/200'),

            // Image.asset(
            //   Assets.imagesLogo,
            //   fit: BoxFit.cover,
            //   width: 100,
            //   height: 50,
            // ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: report.status == 'Solved'
                                ? Colors.green[500]
                                : report.status == 'In Progress'
                                    ? Colors.grey[200]
                                    : Colors.red[500],
                            //color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          report.status,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        report.date,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: AppColors.lightGrayColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    report.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.semibold16inter,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        report.city,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
