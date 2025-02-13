import 'dart:io';

import 'package:civix_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImagePickerBottomSheet {
  static Future<void> show(
      BuildContext context, Function(File?) onImagePicked) async {
    final ImagePicker picker = ImagePicker();

    Future<bool> requestCameraPermission() async {
      var status = await Permission.camera.request();
      return status.isGranted;
    }

    Future<bool> requestGalleryPermission() async {
      var status = await Permission.photos.request();
      return status.isGranted;
    }

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
                title: const Text('Take Photo'),
                onTap: () async {
                  if (await requestCameraPermission()) {
                    Navigator.pop(context);

                    try {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      File? imageFile = File(image.path);
                      onImagePicked(imageFile);
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Camera permission denied')),
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  if (await requestGalleryPermission()) {
                    Navigator.pop(context);
                    try {
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      File? imageFile = File(image.path);
                      onImagePicked(imageFile);
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Gallery permission denied')),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class MultiImagePickerScreen extends StatefulWidget {
  const MultiImagePickerScreen({super.key});

  @override
  _MultiImagePickerScreenState createState() => _MultiImagePickerScreenState();
}

class _MultiImagePickerScreenState extends State<MultiImagePickerScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];
  final int maxImages = 5;
  final int maxImageSizeInBytes = 5 * 1024 * 1024;

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

          if (fileSizeInBytes > maxImageSizeInBytes) {
            // Show error message if the image is too large
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image "${image.name}" exceeds 5 MB')),
            );
            continue; // Skip this image
          }

          setState(() {
            if (_images.length < maxImages) {
              _images.add(image);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Maximum number of images reached')),
              );
            }
          });
        }
        // setState(() {
        //   int availableSlots = maxImages - _images.length;
        //   if (availableSlots > 0) {
        //     _images.addAll(selectedImages.take(availableSlots));
        //   } else {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(content: Text('Maximum number of images reached')),
        //     );
        //   }
        // });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick images: $e')),
      );
    }
  }

  Future<void> pickImagesFromCamera() async {
    if (await requestCameraPermission()) {
      Navigator.pop(context);

      try {
        final XFile? selectedImage =
            await _picker.pickImage(source: ImageSource.camera);
        if (selectedImage != null) {
          final File file = File(selectedImage.path);
          final int fileSizeInBytes = await file.length();

          if (fileSizeInBytes > maxImageSizeInBytes) {
            // Show error message if the image is too large
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Image "${selectedImage.name}" exceeds 5 MB')),
            );
            // Skip this image
          }

          setState(() {
            if (_images.length < maxImages) {
              _images.add(selectedImage);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Maximum number of images reached')),
              );
            }
          });

          // setState(() {
          //   int availableSlots = maxImages - _images.length;
          //   if (availableSlots > 0) {
          //     _images.add(selectedImage);
          //   } else {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //           content: Text('Maximum number of images reached')),
          //     );
          //   }
          // });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick images: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission denied')),
      );
    }
  }

  Future<void> show(
    BuildContext context,
  ) async {
    final ImagePicker picker = ImagePicker();

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
                title: const Text('Take Photo'),
                onTap: () async {
                  await pickImagesFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from Gallery'),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                // ReorderableListView for images
                ReorderableListView(
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
                  children: [
                    // Display selected images
                    ..._images.map((image) {
                      return Padding(
                        key: ValueKey(image.path),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Stack(
                          // Unique key for each image
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(image.path),
                                  height: double.infinity,
                                  width: 200,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              right: -5,
                              child: IconButton(
                                icon: const Icon(Icons.cancel,
                                    color: Colors.red, size: 24),
                                onPressed: () {
                                  setState(() {
                                    _images.remove(image);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
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
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.black)),
                        child: const Center(
                          child: Icon(Icons.add, size: 30, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${_images.length} / $maxImages images selected',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
