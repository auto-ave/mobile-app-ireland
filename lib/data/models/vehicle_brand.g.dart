// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleBrandEntity _$VehicleBrandEntityFromJson(Map<String, dynamic> json) {
  return VehicleBrandEntity(
    name: json['name'] as String,
    imageUrl: json['image'] as String,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$VehicleBrandEntityToJson(VehicleBrandEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.imageUrl,
      'description': instance.description,
    };
