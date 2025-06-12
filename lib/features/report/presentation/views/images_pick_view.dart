import 'package:civix_app/core/repos/report_repo.dart';
import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/widgets/image_picker_bloc_consumer.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesPickView extends StatelessWidget {
  const ImagesPickView({super.key});
  static const routeName = '/imagePick';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(
        getIt.get<ReportRepo>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pick Images"),
          centerTitle: true,
        ),
        body: const ImagePickerBlocConsumer(),
      ),
    );
  }
}
