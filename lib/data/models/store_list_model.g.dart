// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreListEntity _$StoreListEntityFromJson(Map<String, dynamic> json) {
  return StoreListEntity(
    name: json['name'] as String,
    distance: json['distance'] as String?,
    rating: json['rating'] as String?,
    servicesStart: json['services_start'] as int?,
    thumbnail: json['thumbnail'] as String?,
    storeSlug: json['slug'] as String?,
  );
}

Map<String, dynamic> _$StoreListEntityToJson(StoreListEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'distance': instance.distance,
      'rating': instance.rating,
      'services_start': instance.servicesStart,
      'thumbnail': instance.thumbnail,
      'slug': instance.storeSlug,
    };
