import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.images});
  final List<String> images;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isOneImage = widget.images.length == 1;
    return Column(
      children: [
        Padding(
          padding: isOneImage
              ? const EdgeInsets.symmetric(horizontal: 16)
              : EdgeInsets.zero,
          child: CarouselSlider(
            items: widget.images.map((imageUrl) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity),
              );
            }).toList(),
            options: CarouselOptions(
              height: 250,
              autoPlay: !isOneImage,
              enlargeCenterPage: !isOneImage,
              enableInfiniteScroll: !isOneImage,
              viewportFraction:
                  isOneImage ? 1.0 : 0.8, // To show one full image at a time
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == entry.key
                    ? AppColors.secondaryColor
                    : Colors.grey,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
