import 'package:civix_app/core/services/get_it_service.dart';

import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/widgets/map_picker_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repos/report_repo.dart';

class LocationPick extends StatelessWidget {
  const LocationPick({
    super.key,
  });
  static const routeName = 'map-picker';

  @override
  Widget build(BuildContext context) {
    final reportCubit = context.read<ReportCubit>();
    return BlocProvider.value(
      value: reportCubit,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pick Location'),
        ),
        body: const MapPickerBlocConsumer(),
      ),
    );
  }
}
