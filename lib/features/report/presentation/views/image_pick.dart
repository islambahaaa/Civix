import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:civix_app/core/helper_functions/build_snack_bar.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/widgets/images_list_view_items.dart';
import 'package:civix_app/features/report/presentation/views/widgets/list_view_image_item.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImagePickView extends StatefulWidget {
  const ImagePickView(
      {super.key, this.onImagePicked, this.indicateCameraPicture});
  final Function(List<XFile>)? onImagePicked;
  final Function(List<Map<String, dynamic>>)? indicateCameraPicture;
  @override
  _ImagePickViewState createState() => _ImagePickViewState();
}

class _ImagePickViewState extends State<ImagePickView> {
  final ImagePicker _picker = ImagePicker();
  final List<Map<String, dynamic>> _images = [];
  final int maxImages = 5;
  final int maxImageSizeInBytes = 5 * 1024 * 1024;

  Future<bool> isDuplicate(XFile newFile) async {
    List<int> newBytes = await File(newFile.path).readAsBytes();
    String newHash = base64Encode(newBytes);

    for (XFile existingFile in getImages()) {
      List<int> existingBytes = await File(existingFile.path).readAsBytes();
      String existingHash = base64Encode(existingBytes);

      if (existingHash == newHash) return true;
    }
    return false;
  }

  List<XFile> getImages() => _images.map((e) => e['file'] as XFile).toList();
  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> requestGalleryPermission() async {
    var status = await Permission.photos.request();
    return status.isGranted;
  }

  Future<XFile> compressImage(XFile file) async {
    final String filePath = file.path;
    final String targetPath =
        filePath.replaceAll(RegExp(r'\.\w+$'), '_compressed.jpg');

    XFile? compressedFile = await FlutterImageCompress.compressAndGetFile(
      filePath,
      targetPath,
      quality: 80, // Adjust compression quality (1-100)
      format: CompressFormat.jpeg, // Convert all formats to JPG
    );

    return compressedFile ?? file; // Return original if compression fails
  }

  void addImage(XFile image, bool isCamera) async {
    setState(() {
      if (_images.length < maxImages) {
        _images.add({'file': image, 'isCamera': isCamera});
        widget.onImagePicked!(getImages());
        widget.indicateCameraPicture!(_images);
      }
    });
  }

  void removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      widget.onImagePicked!(getImages());
      widget.indicateCameraPicture!(_images);
    });
  }

  Future<void> pickImagesFromGallery() async {
    Navigator.pop(context);

    try {
      final List<XFile> selectedImages = await _picker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        for (var image in selectedImages) {
          final File file = File(image.path);
          final int fileSizeInBytes = await file.length();
          XFile compressedImage =
              await compressImage(image); // Compress before adding
          if (await isDuplicate(compressedImage)) {
            buildSnackBar(context, S.of(context).image_selected);
            continue;
          }
          if (fileSizeInBytes > maxImageSizeInBytes) {
            // Show error message if the image is too large
            buildSnackBar(context,
                "${S.of(context).image}${image.name}${S.of(context).image_exceeds}");
            continue; // Skip this image
          }
          addImage(compressedImage, false);
        }
      }
    } catch (e) {
      buildSnackBar(context, '${S.of(context).image_pick_fail}${e.toString()}');
    }
  }

  Future<void> pickImagesFromCamera() async {
    if (await requestCameraPermission()) {
      Navigator.pop(context);

      try {
        final XFile? selectedImage =
            await _picker.pickImage(source: ImageSource.camera);
        if (selectedImage != null) {
          XFile compressedImage =
              await compressImage(selectedImage); // Compress before adding
          addImage(compressedImage, true);
        }
      } catch (e) {
        buildSnackBar(
            context, '${S.of(context).image_pick_fail}${e.toString()}');
      }
    } else {
      buildSnackBar(context, S.of(context).camera_denied);
    }
  }

  Future<void> show(
    BuildContext context,
  ) async {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(S.of(context).take_photo),
                onTap: () async {
                  await pickImagesFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text(S.of(context).choose_gallery),
                onTap: () async {
                  await pickImagesFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Images"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    isLight ? AppColors.lightprimaryColor2 : Colors.grey[900],
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: isLight
                    ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              height: MediaQuery.of(context).size.height * 0.28,
              child: Stack(
                children: [
                  _images.isEmpty
                      ? const Center(child: ImageWidgetPlaceHolder())
                      : ReorderableListView.builder(
                          itemCount: _images.length,
                          scrollDirection: Axis.horizontal,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) newIndex -= 1;
                              final moved = _images.removeAt(oldIndex);
                              _images.insert(newIndex, moved);
                            });
                          },
                          itemBuilder: (context, index) {
                            final image = _images[index]['file'] as XFile;
                            return ReorderableListViewItem(
                              key: ValueKey(image.path),
                              image: image,
                              onPressed: () {
                                setState(() {
                                  removeImage(index);
                                  widget.onImagePicked?.call(getImages());
                                });
                              },
                            );
                          },
                        ),
                  if (_images.length < maxImages)
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: FloatingActionButton.extended(
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                        label: const Text("Add"),
                        onPressed: () => show(context),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: _images.isNotEmpty ? () {} : null,
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Next"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(140, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SampleImagesViewer extends StatelessWidget {
  final List<Map<String, String>> samples = const [
    {"path": "assets/images/cairo.jpg", "label": "Front View"},
    {"path": "assets/images/cairo.jpg", "label": "Good Lighting"},
    {"path": "assets/images/cairo.jpg", "label": "Side View"},
    {"path": "assets/images/cairo.jpg", "label": "Full View"},
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (_) => SamplePhotoGuidePage(),
                //     ));
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

class FullScreenImageViewer extends StatelessWidget {
  final String imagePath;

  const FullScreenImageViewer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InteractiveViewer(
              child: Image.asset(imagePath),
            ),
          ),
        ),
      ),
    );
  }
}

void showFullImageDialog(BuildContext context, String imagePath) {
  showDialog(
    context: context,
    builder: (_) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Dialog(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            child: Image.asset(imagePath),
          ),
        ),
      ),
    ),
  );
}
