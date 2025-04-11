import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/features/my_reports/presentation/views/widgets/my_reports_header.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class SolvedInMyAreaView extends StatelessWidget {
  const SolvedInMyAreaView({super.key});
  static const routeName = '/solved-in-my-area';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.8),
        title: Text(S.of(context).solved_area_ab),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            TextField(
                decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              labelText: S.of(context).city,
              border: const OutlineInputBorder(),
            )),
            const SizedBox(
              height: 16,
            ),
            TextField(
                decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              labelText: S.of(context).region,
              border: const OutlineInputBorder(),
            )),
            const SizedBox(
              height: 16,
            ),
            const NewestReportsHeader(),
          ],
        ),
      ),
    );
  }
}
