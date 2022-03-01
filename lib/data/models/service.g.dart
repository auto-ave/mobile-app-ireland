// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceEntity _$ServiceEntityFromJson(Map<String, dynamic> json) {
  return ServiceEntity(
    id: json['id'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    thumbnail: json['thumbnail'] as String?,
    bannerUrl: json['banner'] as String?,
    slug: json['slug'] as String?,
  );
}

Map<String, dynamic> _$ServiceEntityToJson(ServiceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'banner': instance.bannerUrl,
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'thumbnail': instance.thumbnail,
      'slug': instance.slug,
    };
