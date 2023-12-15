import 'package:flutter/cupertino.dart';

class Bannermodel {
  final int id;
  final String villatitle;
  final String photo;
  final String bannerType;
  final int published;
  final String createdAt;
  final String updatedAt;
  final String url;
  final String? resourceType;
  final int? resourceId;
  final String folder;

  Bannermodel({
    required this.id,
    required this.villatitle,
    required this.photo,
    required this.bannerType,
    required this.published,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
    this.resourceType,
    this.resourceId,
    required this.folder,
  });

  factory Bannermodel.fromJson(Map<String, dynamic> json) {
    return Bannermodel(
      villatitle: json['villa_title'] ?? 0,
      id: json['id'] ?? 0,
      photo: json['photo'] ?? '',
      bannerType: json['villa_city'] ?? '',
      published: json['published'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      url: json['url'] ?? '',
      resourceType: json['resource_type'],
      resourceId: json['resource_id'],
      folder: json['folder'] ?? '',
    );
  }
}
