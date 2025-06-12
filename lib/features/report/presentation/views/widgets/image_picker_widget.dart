import 'dart:convert';
import 'dart:io';

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

class MultiImagePickerScreen extends StatefulWidget {
  const MultiImagePickerScreen(
      {super.key, this.onImagePicked, this.indicateCameraPicture});
  final Function(List<XFile>)? onImagePicked;
  final Function(List<Map<String, dynamic>>)? indicateCameraPicture;
  @override
  _MultiImagePickerScreenState createState() => _MultiImagePickerScreenState();
}

class _MultiImagePickerScreenState extends State<MultiImagePickerScreen> {
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.withOpacity(0.5) // Light mode shadow
                    : Colors.transparent,
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              width: 1.8,
              color: AppColors.primaryColor,
            ),
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.lightprimaryColor2
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Stack(
            children: [
              // ReorderableListView for images
              _images.isEmpty
                  ? const ImageWidgetPlaceHolder()
                  : ReorderableListView.builder(
                      itemCount: _images.length,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      autoScrollerVelocityScalar: 5,
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }

                          final Map<String, dynamic> movedImage =
                              _images.removeAt(oldIndex);
                          _images.insert(newIndex, movedImage);
                        });
                      },
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final image = _images[index]['file'] as XFile;
                        // Display selected images

                        return ReorderableListViewItem(
                          key: ValueKey(image.path),
                          image: image,
                          onPressed: () {
                            setState(() {
                              removeImage(index);
                              widget.onImagePicked!(getImages());
                            });
                          },
                        );
                      }),

              // Static "Add" button
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
        const SizedBox(height: 16),
        Text(
          '${_images.length} / $maxImages ${S.of(context).images_selected}',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
