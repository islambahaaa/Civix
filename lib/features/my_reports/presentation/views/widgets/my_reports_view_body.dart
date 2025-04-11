import 'package:civix_app/features/my_reports/presentation/cubit/my_reports_cubit.dart';
import 'package:civix_app/features/my_reports/presentation/views/widgets/my_reports_header.dart';
import 'package:civix_app/core/widgets/report_widgets/reports_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyReportsViewBody extends StatelessWidget {
  const MyReportsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RefreshIndicator(
        onRefresh: () =>
            BlocProvider.of<MyReportsCubit>(context).fetchMyReports(),
        child: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  NewestReportsHeader(),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            ReportsSliverList(),
          ],
        ),
      ),
    );
  }
}
