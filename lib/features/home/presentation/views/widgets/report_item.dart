import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/features/home/presentation/views/widgets/custom_report_image.dart';
import 'package:flutter/material.dart';

class ReportItem extends StatelessWidget {
  const ReportItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        // height: 100,
        child: Row(
          children: [
            // CustomReportImage(
            //     borderRadius: BorderRadius.circular(12),
            //     imageUrl:
            //         'https://media.istockphoto.com/id/1628010210/photo/empty-streets-and-sidewalks-of-soho-are-eerily-quiet-during-the-2020-coronavirus-pandemic.webp?s=2048x2048&w=is&k=20&c=i1vvTegni7jpYT5K_zsuWnFbcf1FfgjItdf6NtDcLXg='),

            Image.asset(
              Assets.imagesLogo,
              fit: BoxFit.cover,
              width: 100,
              height: 50,
            ),
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
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          'Solved',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Jan 4,2022',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: AppColors.lightGrayColor),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Problem title',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.semibold16inter,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Giza',
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
