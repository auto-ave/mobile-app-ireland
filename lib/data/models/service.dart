import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

class ServiceModel {
  final int id;
  final DateTime createdAt;

  final DateTime updatedAt;

  final String? name;
  final String? description;
  final String? thumbnail;
  final List<String>? images;
  ServiceModel(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.name,
      this.description,
      this.images,
      this.thumbnail});
  factory ServiceModel.fromEntity(ServiceEntity e) {
    return ServiceModel(
        id: e.id,
        createdAt: DateTime.parse(e.createdAt),
        updatedAt: DateTime.parse(e.updatedAt),
        description: e.description,
        images: e.images,
        name: e.name,
        thumbnail: e.thumbnail);
  }

  @override
  String toString() {
    return 'ServiceModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, description: $description, thumbnail: $thumbnail, images: $images)';
  }
}

@JsonSerializable()
class ServiceEntity {
  final int id;

  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  final String? name;
  final String? description;
  final List<String>? images;
  final String? thumbnail;
  ServiceEntity(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.name,
      this.description,
      this.images,
      this.thumbnail});
  factory ServiceEntity.fromJson(Map<String, dynamic> data) =>
      _$ServiceEntityFromJson(data);

  Map<String, dynamic> toJson() => _$ServiceEntityToJson(this);
}
