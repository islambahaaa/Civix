class ReportEntity {
  final String id;
  final String title;
  final String description;
  final double lat;
  final double long;
  final String category;
  final String status;
  final String date;
  final List<String> images;

  ReportEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.lat,
      required this.long,
      required this.category,
      required this.status,
      required this.date,
      required this.images});
}
