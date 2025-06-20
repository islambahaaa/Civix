import 'dart:developer';

import 'package:civix_app/generated/l10n.dart';

Map<String, int> categoryMap = {
  'broken streetlights': 1,
  'broken streetlight': 1,
  'garbage': 2,
  'graffiti': 3,
  'manhole': 4,
  'pothole': 5, // Fixed spelling
  'unknown': 6,
};
int getCategoryId(String category) {
  return categoryMap[category.trim().toLowerCase()] ??
      6; // Returns 0 if category is not found
}

String getCategory(int id) {
  return categoryMap.entries.firstWhere((entry) => entry.value == id).key;
}
