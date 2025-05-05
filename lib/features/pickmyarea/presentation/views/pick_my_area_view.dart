import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/widgets/custom_progress_hud.dart';
import 'package:civix_app/features/pickmyarea/domain/repos/pick_my_area_repo.dart';
import 'package:civix_app/features/pickmyarea/presentation/views/widgets/pick_my_area_view_body.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/pick_my_area_cubit/pick_my_area_cubit.dart';
import '../cubits/pick_my_area_cubit/pick_my_area_state.dart';

class PickMyAreaView extends StatelessWidget {
  const PickMyAreaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PickMyAreaCubit(
        getIt.get<PickMyAreaRepo>(),
      )..fetchAreas(),
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).select_location)),
        body: BlocBuilder<PickMyAreaCubit, PickMyAreaState>(
          builder: (context, state) {
            if (state is PickMyAreaLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PickMyAreaFailure) {
              return Center(child: Text('Error: ${state.error}'));
            }
            if (state is PickMyAreaSuccess) {
              return PickMyAreaViewBody(
                areas: state.areas,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
