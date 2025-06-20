import 'dart:developer';

import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/location_pick.dart';
import 'package:civix_app/features/report/presentation/views/widgets/image_picker_widget.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_fields.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportViewBody extends StatefulWidget {
  const ReportViewBody({
    super.key,
  });

  @override
  State<ReportViewBody> createState() => _ReportViewBodyState();
}

class _ReportViewBodyState extends State<ReportViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String title, description;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(children: [
              CustomTitleField(
                onSaved: (value) {
                  title = value!;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              CustomDescriptionField(
                onSaved: (value) {
                  description = value!;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (context.read<ReportCubit>().isCameraImage) {
                        context.read<ReportCubit>().submitReportFromCamera(
                              title,
                              description,
                            );
                      } else {
                        context.read<ReportCubit>().saveFieldsInCubit(
                              title,
                              description,
                            );
                        if (context.read<ReportCubit>().images.isNotEmpty) {
                          Navigator.of(context).pushNamed(
                              LocationPick.routeName,
                              arguments: BlocProvider.of<ReportCubit>(context));
                        } else {
                          buildSnackBar(context, S.of(context).provide_images);
                        }
                      }
                    } else {
                      //buildSnackBar(context, S.of(context).fill_fields);
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  text: S.of(context).submit)
            ]),
          ),
        ));
  }
}
