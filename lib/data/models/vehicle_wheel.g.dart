// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_wheel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleWheelEntity _$VehicleWheelEntityFromJson(Map<String, dynamic> json) {
  return VehicleWheelEntity(
    code: json['code'] as String,
    name: json['name'] as String,
    imageUrl: json['image'] as String,
  );
}

Map<String, dynamic> _$VehicleWheelEntityToJson(VehicleWheelEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'image': instance.imageUrl,
    };
