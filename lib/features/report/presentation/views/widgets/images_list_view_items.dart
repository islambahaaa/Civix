import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/features/report/presentation/views/widgets/list_view_image_item.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReorderableListViewItem extends StatelessWidget {
  const ReorderableListViewItem({
    super.key,
    required this.image,
    this.onPressed,
  });

  final XFile image;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(image.path),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        // Unique key for each image
        children: [
          ListViewImageItem(image: image),
          Positioned(
            top: -5,
            right: -5,
            child: IconButton(
              icon: const Icon(Icons.cancel, color: Colors.red, size: 24),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class AddImageIcon extends StatelessWidget {
  const AddImageIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Center(
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}

class ImageWidgetPlaceHolder extends StatelessWidget {
  const ImageWidgetPlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.imagesSendReport,
          width: 45,
          height: 45,
        ),
        const Text(
          'Image size must be less than 5 MB',
        ),
      ],
    ));
  }
}
