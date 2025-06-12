import 'package:civix_app/generated/l10n.dart';

Map<String, int> categoryMap = {
  S.current.pothole: 1,
  S.current.broken_streetlight: 2,
  S.current.garbage: 3,
  S.current.manhole: 4,
  S.current.graffiti: 5, // Fixed spelling
  S.current.flooding: 6,
  S.current.other: 7,
};
int getCategoryId(String category) {
  return categoryMap[category] ?? 0; // Returns 0 if category is not found
}

String getCategory(int id) {
  return categoryMap.entries.firstWhere((entry) => entry.value == id).key;
}
