import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'dart:developer';
import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/core/widgets/custom_progress_hud.dart';
import 'package:civix_app/features/report/presentation/views/report_view.dart';
import 'package:civix_app/features/report/presentation/views/widgets/image_pick_view_body.dart';
import 'package:civix_app/features/report/presentation/views/widgets/map_picker_view.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_fields.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ImagePickerBlocConsumer extends StatelessWidget {
  const ImagePickerBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportCubit>();
    return BlocConsumer<ReportCubit, ReportState>(listener: (context, state) {
      if (state is ReportPredictionSuccess) {
        showCategoryDialog(context, state, cubit);
      }

      if (state is ReportFailure) {
        buildSnackBar(context, state.message);
        showManualCategoryDialog(context, cubit);
      }
    }, builder: (context, state) {
      return CustomProgressHud(
        isLoading: state is ReportLoading,
        child: const ImagePickViewBody(),
      );
    });
  }
}
