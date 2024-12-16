import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
import 'package:civix_app/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:civix_app/constants.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:svg_flutter/svg_flutter.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        fname: state.user.fname,
                        lname: state.user.lname,
                      );
                    } else if (state is UserFailure) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(child: Text('No user data.'));
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
