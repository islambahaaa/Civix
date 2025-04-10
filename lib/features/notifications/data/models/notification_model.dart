import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime time;
  bool isRead;
  final IconData icon;
  final Color color;
  final String type;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    required this.icon,
    required this.color,
    required this.type,
  });

  // factory NotificationModel.fromJson(Map<String, dynamic> json) {
  //   return NotificationModel(
  //     title: json['title'],
  //     message: json['message'],
  //     timestamp: DateTime.parse(json['timestamp']),
  //   );
  // }
}
