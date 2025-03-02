import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/core/widgets/custom_progress_hud.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportViewBodyBlocConsumer extends StatelessWidget {
  const ReportViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportCubit, ReportState>(
      listener: (context, state) {
        if (state is ReportSuccess) {
          BuildContext rootContext =
              Navigator.of(context, rootNavigator: true).context;

          Navigator.of(context).pop(); // Close the current screen

          Future.delayed(const Duration(milliseconds: 300), () {
            showCustomDialog(rootContext, 'Report submitted successfully.}');

            Future.delayed(const Duration(seconds: 2), () {
              if (rootContext.mounted) {
                Navigator.of(rootContext).pop(); // Close the dialog
              }
            });
          });
        }
        if (state is ReportFailure) {
          buildSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is ReportLoading,
          child: const ReportViewBody(),
        );
      },
    );
  }
}
