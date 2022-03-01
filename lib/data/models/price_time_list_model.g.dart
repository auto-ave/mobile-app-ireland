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
    timeInterval: json['time_interval'] as String?,
    description: json['description'] as String?,
    store: json['store'] as int?,
    vehicleType: json['vehicle_type'] as String?,
    bays: (json['bays'] as List<dynamic>?)?.map((e) => e as int).toList(),
    mrp: json['mrp'] as int?,
    offer: json['offer'] == null
        ? null
        : PriceTimeOfferDetail.fromJson(json['offer'] as Map<String, dynamic>),
    tags: (json['tags'] as List<dynamic>?)
        ?.map((e) => ServiceEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
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
      'mrp': instance.mrp,
      'offer': instance.offer?.toJson(),
      'time_interval': instance.timeInterval,
      'description': instance.description,
      'store': instance.store,
      'vehicle_type': instance.vehicleType,
      'bays': instance.bays,
      'tags': instance.tags?.map((e) => e.toJson()).toList(),
    };

PriceTimeOfferDetail _$PriceTimeOfferDetailFromJson(Map<String, dynamic> json) {
  return PriceTimeOfferDetail(
    offerText: json['text'] as String?,
    offerCode: json['code'] as String?,
  );
}

Map<String, dynamic> _$PriceTimeOfferDetailToJson(
        PriceTimeOfferDetail instance) =>
    <String, dynamic>{
      'text': instance.offerText,
      'code': instance.offerCode,
    };
