import 'dart:io';

import 'package:civix_app/features/report/presentation/views/widgets/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});
  static const routeName = '/report';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Report'),
        ),
        body: const MultiImagePickerScreen()
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     //Center(child: ImagePickerWidget()),

        //   ],
        // ),
        );
  }
}
