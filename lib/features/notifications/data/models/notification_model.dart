import 'package:civix_app/core/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'notification_model.g.dart';

@HiveType(typeId: 0)
class NotificationModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final DateTime time;
  @HiveField(4)
  bool isRead;
  @HiveField(5)
  String? image;
  final ReportModel? issue;

  NotificationModel({
    required this.id,
    this.image,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    this.issue,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: UniqueKey().toString(), // or use a UUID
      title: json['title'],
      body: json['body'],
      image: json['imageUrl'],
      time: DateTime.parse(
        json['issue']?['updatedOn'] ?? DateTime.now().toIso8601String(),
      ),
      isRead: false,
      issue: json['issue'] != null ? ReportModel.fromJson(json['issue']) : null,
    );
  }
}
