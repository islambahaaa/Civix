import 'package:flutter/material.dart';

Color getStatusColor(String status, BuildContext context) {
  String statusLower = status.toLowerCase();

  switch (statusLower) {
    case 'open':
      return Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF2196F3) // Sky Blue for Open (Light Theme)
          : Colors.blue.shade700; // Darker Blue for Open (Dark Theme)
    case 'inprogress':
      return Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFFF9800) // Amber for InProgress (Light Theme)
          : const Color(0xFFF57C00); // Darker Amber for InProgress (Dark Theme)
    case 'resolved':
      return Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF4CAF50) // Emerald Green for Resolved (Light Theme)
          : const Color(0xFF388E3C); // Darker Green for Resolved (Dark Theme)
    default:
      return Colors.grey; // Fallback for unknown status
  }
}
