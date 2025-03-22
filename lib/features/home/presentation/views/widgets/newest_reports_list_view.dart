import 'package:civix_app/features/home/data/models/report_model.dart';
import 'package:civix_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:civix_app/features/home/presentation/views/widgets/report_item.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class NewestReportsListView extends StatelessWidget {
  const NewestReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return _buildShimmerLoading();
        } else if (state is HomeSuccess) {
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
        } else if (state is HomeFailure) {
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

class NewestReportsList extends StatelessWidget {
  const NewestReportsList({
    super.key,
    required this.reports,
  });

  final List<ReportModel> reports;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: reports.length,
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

class ShimmerNewestListView extends StatelessWidget {
  const ShimmerNewestListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!.withOpacity(0.5),
      highlightColor: Colors.transparent,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 4,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 90,
                    child: Row(
                      children: [
                        ShimmerListViewItem(),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Skelton(
                                    width: 40,
                                    height: 20,
                                  ),
                                  Spacer(),
                                  Skelton(
                                    width: 40,
                                    height: 20,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Skelton(
                                width: double.infinity,
                                height: 20,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Skelton(
                                width: 40,
                                height: 15,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Divider(
                    thickness: 0.15,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({
    super.key,
    this.width,
    this.height,
  });
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      height: height,
      width: width,
    );
  }
}

class ShimmerListViewItem extends StatelessWidget {
  const ShimmerListViewItem({
    super.key,
    this.padding,
  });
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 4 / 3.5,
          child: Container(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
