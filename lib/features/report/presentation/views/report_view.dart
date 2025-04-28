import 'dart:io';

import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/core/repos/report_repo.dart';
import 'package:civix_app/core/services/get_it_service.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/core/widgets/custom_text_form_field.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/widgets/image_picker_widget.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_fields.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_view_bloc_consumer.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_view_body.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});
  static const routeName = '/report';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(
        getIt.get<ReportRepo>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.8),
          centerTitle: true,
          title: Text(S.of(context).report),
        ),
        body: const ReportViewBodyBlocConsumer(),
      ),
    );
  }
}
