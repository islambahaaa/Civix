import 'package:civix_app/core/helper_functions/show_full_image.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class UserGuidePage extends StatelessWidget {
  final List<GuideStep> steps = [
    GuideStep(
      imagePath: Assets.imagesStreetlight,
      title: 'Capture from the Side',
      description:
          'Take the streetlight photo from the side to show its full structure.',
    ),
    GuideStep(
      imagePath: Assets.imagesManhole,
      title: 'Shoot Directly Above',
      description:
          'Photograph the manhole straight from above to clearly show its condition.',
    ),
    GuideStep(
      imagePath: Assets.imagesGraffiti,
      title: 'Focus on the Graffiti',
      description:
          'Frame the graffiti to fill most of the image and avoid distractions.',
    ),
    GuideStep(
      imagePath: Assets.imagesPothole,
      title: 'Get Close to the Pothole',
      description:
          'Take the photo from a short distance to show the size and depth clearly.',
    ),
    GuideStep(
      imagePath: Assets.imagesGarbage,
      title: 'Show the Garbage Clearly',
      description:
          'Capture the garbage pile fully, including its location on the street.',
    ),
  ];

  UserGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Take Great Photos'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Follow these simple steps to take photos that are clear, useful, and easy to review.',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ...steps.map((step) => GuideCard(step: step)),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: Colors.orange),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Pro Tip: Clean your camera lens before snapping a photo!',
                    style: TextStyle(fontSize: 14, color: Colors.orange[900]),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.camera_alt),
            label: const Text('Start Taking Photos'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class GuideStep {
  final String imagePath;
  final String title;
  final String description;

  GuideStep({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class GuideCard extends StatelessWidget {
  final GuideStep step;

  const GuideCard({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showFullImageDialog(context, step.imagePath),
      child: Card(
        margin: const EdgeInsets.only(bottom: 20),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                step.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 180,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    step.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
