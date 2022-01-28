// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_day_slot_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiDaySlotDetailEntity _$MultiDaySlotDetailEntityFromJson(
    Map<String, dynamic> json) {
  return MultiDaySlotDetailEntity(
    delayMessage: json['delay_message'] as String?,
    slots: (json['slots'] as List<dynamic>)
        .map((e) => MultiDaySlotEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MultiDaySlotDetailEntityToJson(
        MultiDaySlotDetailEntity instance) =>
    <String, dynamic>{
      'delay_message': instance.delayMessage,
      'slots': instance.slots.map((e) => e.toJson()).toList(),
    };
