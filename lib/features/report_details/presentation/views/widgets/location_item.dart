import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, color: Colors.green),
        const SizedBox(width: 8),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
