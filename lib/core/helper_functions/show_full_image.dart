import 'dart:ui';

import 'package:flutter/material.dart';

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
