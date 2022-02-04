// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferEntity _$OfferEntityFromJson(Map<String, dynamic> json) {
  return OfferEntity(
    id: json['id'] as num?,
    code: json['code'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    saving: json['saving'] as String?,
    banner: json['banner'] as String?,
  );
}

Map<String, dynamic> _$OfferEntityToJson(OfferEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'title': instance.title,
      'description': instance.description,
      'banner': instance.banner,
      'saving': instance.saving,
    };
