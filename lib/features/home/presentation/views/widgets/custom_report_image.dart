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
    return GestureDetector(
      onTap: () {
        // if (book != null) {
        //   GoRouter.of(context).push(AppRouter.kBookDetailsRoute, extra: book);
        // }
      },
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 2.6 / 4,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
