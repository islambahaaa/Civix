import 'package:civix_app/core/widgets/report_widgets/reports_sliver_list.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:civix_app/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:civix_app/features/home/presentation/views/widgets/solved_in_my_area.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:civix_app/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    this.onNameTap,
  });
  final void Function()? onNameTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RefreshIndicator(
        onRefresh: () => BlocProvider.of<HomeCubit>(context).fetchMyReports(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: kVerticalPadding,
                  ),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is UserSuccess) {
                        return CustomHomeAppBar(
                          onTap: onNameTap,
                          fname: state.user.fname,
                          lname: state.user.lname,
                        );
                      } else if (state is UserFailure) {
                        return Center(child: Text(state.message));
                      } else {
                        return Center(child: Text(S.of(context).no_user_data));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // const SolvedInMyAreaWidget(),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  //const NewestReportsHeader(),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            const ReportsSliverList(),
          ],
        ),
      ),
    );
  }
}
