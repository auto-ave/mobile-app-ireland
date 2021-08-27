// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventEntity _$EventEntityFromJson(Map<String, dynamic> json) {
  return EventEntity(
    id: json['id'] as int,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    isBlocking: json['is_blocking'] as bool,
    startDateTime: json['start_datetime'] as String,
    endDateTime: json['end_datetime'] as String,
    bay: json['bay'] as int?,
  );
}

Map<String, dynamic> _$EventEntityToJson(EventEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_blocking': instance.isBlocking,
      'start_datetime': instance.startDateTime,
      'end_datetime': instance.endDateTime,
      'bay': instance.bay,
    };
