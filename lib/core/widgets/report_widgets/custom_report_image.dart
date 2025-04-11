import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomReportImage extends StatelessWidget {
  const CustomReportImage(
      {super.key, this.borderRadius, required this.imageUrl});
  final BorderRadius? borderRadius;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    // final BookModel? book;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 4 / 3.5,
        // child: Image.network(imageUrl, fit: BoxFit.cover),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
