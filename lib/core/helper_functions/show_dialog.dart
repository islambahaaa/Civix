import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/report_view.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_fields.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg_flutter.dart';

void showCustomDialog(
    BuildContext context, String title, String text, IconData icon) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppColors.primaryColor, size: 100),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyles.semibold24inter,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      });
}

void showCongratulationsDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(alignment: Alignment.center, children: [
                  SvgPicture.asset(Assets.imagesVerified),
                  SvgPicture.asset(Assets.imagesBubbles),
                ]),
                const SizedBox(height: 20),
                Text(
                  S.of(context).congrats,
                  style: TextStyles.semibold24inter,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  S.of(context).password_reset,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      });
}

void showAreYouSureDialog(BuildContext context, VoidCallback onYesPressed) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).are_you_sure,
                  style: TextStyles.semibold24inter,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  S.of(context).logout_confirm,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xfff0f0f2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(S.of(context).cancel,
                              style: TextStyles.semibold16inter.copyWith(
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        text: S.of(context).logout,
                        onPressed: onYesPressed,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

Future<dynamic> showCategoryDialog(
  BuildContext context,
  ReportPredictionSuccess state,
  ReportCubit cubit,
) {
  return showDialog(
    context: context,
    builder: (context) {
      String? selectedCategory;
      bool showDropdown = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              "Is this correct?",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!showDropdown)
                  Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "We predicted the issue is",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                  text: " ${state.predictedCategory}",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.orange,
                                  ),
                                ),
                              ]),
                        ],
                      )),
                if (showDropdown) ...[
                  const Text("Please choose the correct category:"),
                  const SizedBox(height: 10),
                  DropdownMenuExample(
                    onSelected: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ],
              ],
            ),
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            actions: [
              if (showDropdown) ...[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton.icon(
                  onPressed: selectedCategory != null
                      ? () {
                          cubit.saveCategory(selectedCategory!);
                          Navigator.pop(context);
                          Navigator.pushNamed(context, ReportView.routeName,
                              arguments: cubit);
                        }
                      : null,
                  icon: const Icon(Icons.check),
                  label: const Text("Confirm"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(110, 45),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ] else ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      showDropdown = true;
                    });
                  },
                  child: const Text(
                    "No, I’ll choose",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    cubit.saveCategory(state.predictedCategory);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, ReportView.routeName,
                        arguments: cubit);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(140, 45),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.check),
                  label: const Text("Yes"),
                ),
              ],
            ],
          );
        },
      );
    },
  );
}

Future<dynamic> showManualCategoryDialog(
  BuildContext context,
  ReportCubit cubit,
) {
  return showDialog(
    context: context,
    builder: (context) {
      String? selectedCategory;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text(
              'Choose the correct category',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'AI could not predict this issue.\nPlease pick a category:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                DropdownMenuExample(
                  onSelected: (value) => setState(() {
                    selectedCategory = value;
                  }),
                ),
              ],
            ),
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton.icon(
                onPressed: selectedCategory != null
                    ? () {
                        cubit.saveCategory(selectedCategory!);
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          ReportView.routeName,
                          arguments: cubit,
                        );
                      }
                    : null,
                icon: const Icon(Icons.check),
                label: const Text('Confirm'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(110, 45),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
