import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/helper_functions/show_full_image.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/instructions_view.dart';
import 'package:civix_app/features/report/presentation/views/widgets/image_picker_widget.dart';
import 'package:civix_app/features/report/presentation/views/widgets/images_list_view_items.dart';
import 'package:civix_app/features/report/presentation/views/widgets/list_view_image_item.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImagePickViewBody extends StatelessWidget {
  const ImagePickViewBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SampleImagesViewer(),
            const SizedBox(height: 10),
            Text(
              "Selected Images",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            MultiImagePickerScreen(
              onImagePicked: (images) {
                BlocProvider.of<ReportCubit>(context).addImages(images);
              },
              indicateCameraPicture: (flagedimages) {
                bool hasCameraImage =
                    flagedimages.any((image) => image['isCamera'] == true);
                context.read<ReportCubit>().isCameraImage = hasCameraImage;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SampleImagesViewer extends StatelessWidget {
  final List<Map<String, String>> samples = const [
    {"path": Assets.imagesSample1, "label": "Graffiti"},
    {"path": Assets.imagesPothole, "label": "Pothole"},
    {"path": Assets.imagesGarbage, "label": "Garbage"},
    {"path": Assets.imagesSample4, "label": "Broken Streetlight"},
    {"path": Assets.imagesSample5, "label": "Manhole"},
  ];

  const SampleImagesViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sample Photos",
                style: Theme.of(context).textTheme.titleMedium),
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserGuidePage(),
                    ));
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: samples.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final sample = samples[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => showFullImageDialog(
                      context,
                      sample["path"]!,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        sample["path"]!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sample["label"]!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// class FullScreenImageViewer extends StatelessWidget {
//   final String imagePath;

//   const FullScreenImageViewer({super.key, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: GestureDetector(
//         onTap: () => Navigator.pop(context),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: InteractiveViewer(
//               child: Image.asset(imagePath),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
