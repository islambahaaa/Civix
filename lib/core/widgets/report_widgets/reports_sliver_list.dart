import 'package:civix_app/core/widgets/shimmer_widgets.dart';
import 'package:civix_app/features/my_reports/presentation/cubit/my_reports_cubit.dart';
import 'package:civix_app/core/widgets/report_widgets/report_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsSliverList extends StatelessWidget {
  const ReportsSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyReportsCubit, MyReportsState>(
      builder: (context, state) {
        if (state is MyReportsLoading) {
          return _buildShimmerLoading();
        } else if (state is MyReportsSuccess) {
          final reports = state.reports;
          return SliverList.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  children: [
                    ReportItem(report: reports[index]),
                    const SizedBox(height: 7),
                    const Divider(thickness: 0.15),
                  ],
                ),
              );
            },
          );
        } else if (state is MyReportsFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red)),
            ),
          );
        }
        return const SliverToBoxAdapter(); // Return empty if state is unknown
      },
    );
  }

  /// Builds the shimmer loading effect
  Widget _buildShimmerLoading() {
    return const SliverFillRemaining(
      child: ShimmerNewestListView(),
    );
  }
}
