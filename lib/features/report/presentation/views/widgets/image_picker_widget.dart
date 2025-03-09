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
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MultiImagePickerScreen extends StatefulWidget {
  const MultiImagePickerScreen({super.key, this.onImagePicked});
  final Function(List<XFile>)? onImagePicked;
  @override
  _MultiImagePickerScreenState createState() => _MultiImagePickerScreenState();
}

class _MultiImagePickerScreenState extends State<MultiImagePickerScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];
  final int maxImages = 5;
  final int maxImageSizeInBytes = 5 * 1024 * 1024;

  Future<bool> isDuplicate(XFile newFile) async {
    List<int> newBytes = await File(newFile.path).readAsBytes();
    String newHash = base64Encode(newBytes);

    for (XFile existingFile in _images) {
      List<int> existingBytes = await File(existingFile.path).readAsBytes();
      String existingHash = base64Encode(existingBytes);

      if (existingHash == newHash) return true;
    }
    return false;
  }

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> requestGalleryPermission() async {
    var status = await Permission.photos.request();
    return status.isGranted;
  }

  Future<void> pickImagesFromGallery() async {
    Navigator.pop(context);

    try {
      final List<XFile> selectedImages = await _picker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        for (var image in selectedImages) {
          final File file = File(image.path);
          final int fileSizeInBytes = await file.length();
          if (await isDuplicate(image)) {
            buildSnackBar(context, S.of(context).image_selected);
            continue;
          }
          if (fileSizeInBytes > maxImageSizeInBytes) {
            // Show error message if the image is too large
            buildSnackBar(context, S.of(context).image_exceeds);
            continue; // Skip this image
          }

          setState(() {
            if (_images.length < maxImages) {
              _images.add(image);
              widget.onImagePicked!(_images);
            } else {
              buildSnackBar(context, S.of(context).max_images);
            }
          });
        }
      }
    } catch (e) {
      buildSnackBar(context, S.of(context).image_pick_fail);
    }
  }

  Future<void> pickImagesFromCamera() async {
    if (await requestCameraPermission()) {
      Navigator.pop(context);

      try {
        final XFile? selectedImage =
            await _picker.pickImage(source: ImageSource.camera);
        if (selectedImage != null) {
          setState(() {
            if (_images.length < maxImages) {
              _images.add(selectedImage);
              widget.onImagePicked!(_images);
            } else {
              buildSnackBar(context, S.of(context).max_images);
            }
          });
        }
      } catch (e) {
        buildSnackBar(context, S.of(context).image_pick_fail);
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
                          final XFile movedImage = _images.removeAt(oldIndex);
                          _images.insert(newIndex, movedImage);
                        });
                      },
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final image = _images[index];
                        // Display selected images

                        return ReorderableListViewItem(
                          key: ValueKey(image.path),
                          image: image,
                          onPressed: () {
                            setState(() {
                              _images.remove(image);
                            });
                          },
                        );
                      }),

              // Static "Add" button
              if (_images.length < maxImages)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () async {
                      await show(
                        context,
                      );
                    },
                    //onTap: pickImages,
                    child: const AddImageIcon(),
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
