import 'dart:io';

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
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: ImagePickerWidget()),
        ],
      ),
    );
  }
}

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  bool isLoading = false;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () async {
          isLoading = true;
          setState(() {});
          await ImagePickerBottomSheet.show(context, (image) {
            imageFile = image;
            setState(() {});
          });
          isLoading = false;
          setState(() {});
        },
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: imageFile != null
                ? Image.file(imageFile!)
                : const Icon(
                    Icons.camera_alt_rounded,
                    size: 80,
                  ),
          ),
          // Container(
          //     padding: const EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(color: Colors.grey),
          //       color: Colors.red,
          //     ),
          //     child: const Icon(Icons.close)),
          Visibility(
            visible: imageFile != null,
            child: IconButton(
                onPressed: () {
                  setState(() => imageFile = null);
                },
                icon: const Icon(Icons.close)),
          ),
        ]),
      ),
    );
  }
}

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
