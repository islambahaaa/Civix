import 'dart:io';

import 'package:civix_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ListViewImageItem extends StatelessWidget {
  const ListViewImageItem({
    super.key,
    required this.image,
  });

  final XFile image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(image.path),
          height: double.infinity,
          width: 200,
        ),
      ),
    );
  }
}
