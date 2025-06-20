import 'package:civix_app/core/entities/report_entity.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

class ReportModel extends ReportEntity {
  String? city;
  String? time;

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
    this.time,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    String dateTimeString = json['createdOn'] ?? '';

    // Parse date and time
    Map<String, String> parsedDateTime = _parseDateTime(dateTimeString);
    return ReportModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      lat: json['latitude'] ?? 0.0,
      long: json['longitude'] ?? 0.0,
      category: json['category'] ?? '',
      status: json['status'] ?? '',
      date: parsedDateTime['date'] ?? '',
      time: parsedDateTime['time'] ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
  static Map<String, String> _parseDateTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
      String formattedTime = DateFormat('hh:mm a').format(dateTime);
      return {'date': formattedDate, 'time': formattedTime};
    } catch (e) {
      return {'date': dateTimeString, 'time': ''};
    }
  }

  /// Reverse geocoding to get city name (Call this method after creation)
  Future<void> fetchCityName() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        city = [
          place.subThoroughfare,
          place.locality,
          place.administrativeArea,
        ].where((element) => element != null && element.isNotEmpty).join(", ");
      }
    } catch (e) {
      city = 'Unknown';
    }
  }
}
