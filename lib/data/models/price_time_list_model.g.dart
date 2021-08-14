// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_time_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceTimeListEntity _$PriceTimeListEntityFromJson(Map<String, dynamic> json) {
  return PriceTimeListEntity(
    id: json['id'] as int?,
    service: json['service'],
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    price: json['price'] as int?,
    timeInterval: json['time_interval'] as int?,
    description: json['description'] as String?,
    store: json['store'] as int?,
    vehicleType: json['vehicle_type'] as int?,
    bays: (json['bays'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$PriceTimeListEntityToJson(
        PriceTimeListEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service': instance.service,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'price': instance.price,
      'time_interval': instance.timeInterval,
      'description': instance.description,
      'store': instance.store,
      'vehicle_type': instance.vehicleType,
      'bays': instance.bays,
    };
