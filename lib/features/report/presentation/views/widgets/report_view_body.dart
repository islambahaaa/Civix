import 'package:civix_app/core/widgets/custom_button.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/widgets/image_picker_widget.dart';
import 'package:civix_app/features/report/presentation/views/widgets/report_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportViewBody extends StatelessWidget {
  const ReportViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SingleChildScrollView(
        reverse: true,
        child: Column(children: [
          MultiImagePickerScreen(
            onImagePicked: (images) {
              BlocProvider.of<ReportCubit>(context).addImages(images);
            },
          ),
          const SizedBox(height: 20),
          const DropdownMenuExample(),
          const SizedBox(
            height: 20,
          ),
          const CustomTitleField(),
          const SizedBox(
            height: 12,
          ),
          const CustomDescriptionField(),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
              onPressed: () async {
                await BlocProvider.of<ReportCubit>(context).submitReport();
              },
              text: 'Submit')
        ]),
      ),
    ));
  }
}
