import 'package:civix_app/features/home/domain/entities/report_entity.dart';

class ReportModel extends ReportEntity {
  final String? city;

  ReportModel({
    this.city,
    required super.id,
    required super.title,
    required super.description,
    required super.lat,
    required super.long,
    required super.category,
    required super.status,
    required super.date,
    required super.images,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      lat: json['latitude'] ?? 0.0,
      long: json['longitude'] ?? 0.0,
      category: json['category'] ?? 0,
      status: json['status'] ?? '',
      date: json['createdOn'] ?? '',
      images: json['images'] ?? [],
    );
  }
}
