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

class ImagePickerBlocConsumer extends StatelessWidget {
  const ImagePickerBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportCubit>();
    return BlocConsumer<ReportCubit, ReportState>(
      listener: (context, state) {
        if (state is ReportPredictionSuccess) {
          showDialog(
            context: context,
            builder: (context) {
              String? selectedCategory;
              bool showDropdown = false;
              List<String> categoryOptions = [
                "Road Damage",
                "Street Light",
                "Garbage",
                "Water Leak",
                "Other"
              ]; // Replace with your actual categories

              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: const Text("Is this correct?"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!showDropdown)
                          Text(
                              "We predicted the issue is: ${state.predictedCategory}"),
                        if (showDropdown) ...[
                          const Text("Select the correct category:"),
                          const SizedBox(height: 8),
                          DropdownMenuExample(onSelected: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          }),
                        ],
                      ],
                    ),
                    actions: [
                      if (!showDropdown)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showDropdown = true;
                            });
                          },
                          child: const Text("No, I’ll choose"),
                        ),
                      if (showDropdown)
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                      SizedBox(
                        width: 90,
                        child: CustomButton(
                          onPressed: () {
                            cubit.saveCategory(state.predictedCategory);
                            Navigator.pop(context);
                          },
                          text: showDropdown ? "Confirm" : "Yes",
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        }

        if (state is ReportFailure) {
          buildSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is ReportLoading,
          child: const ImagePickViewBody(),
        );
      },
    );
  }
}
