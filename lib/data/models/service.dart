import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

class ServiceModel {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? description;
  final String? thumbnail;
  final String? bannerUrl;
  final List<String>? images;
  final String? slug;
  ServiceModel(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.name,
      this.description,
      this.images,
      this.thumbnail,
      required this.slug,
      required this.bannerUrl});
  factory ServiceModel.fromEntity(ServiceEntity e) {
    return ServiceModel(
        id: e.id,
        createdAt: e.createdAt != null ? DateTime.parse(e.createdAt!) : null,
        updatedAt: e.updatedAt != null ? DateTime.parse(e.updatedAt!) : null,
        description: e.description,
        images: e.images,
        name: e.name,
        thumbnail: e.thumbnail,
        slug: e.slug,
        bannerUrl: e.bannerUrl);
  }

  @override
  String toString() {
    return 'ServiceModel(id: $id, banner: $bannerUrl, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, description: $description, thumbnail: $thumbnail, images: $images)';
  }
}

@JsonSerializable()
class ServiceEntity {
  final int? id;

  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'banner')
  final String? bannerUrl;
  final String? name;
  final String? description;
  final List<String>? images;
  final String? thumbnail;
  final String? slug;

  ServiceEntity(
      {this.id,
      required this.createdAt,
      required this.updatedAt,
      this.name,
      this.description,
      this.images,
      this.thumbnail,
      this.bannerUrl,
      required this.slug});
  factory ServiceEntity.fromJson(Map<String, dynamic> data) =>
      _$ServiceEntityFromJson(data);

  Map<String, dynamic> toJson() => _$ServiceEntityToJson(this);
}
