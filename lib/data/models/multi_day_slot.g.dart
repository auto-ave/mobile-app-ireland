// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_day_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiDaySlotEntity _$MultiDaySlotEntityFromJson(Map<String, dynamic> json) {
  return MultiDaySlotEntity(
    image: json['image'] as String,
    title: json['title'] as String,
    time: json['time'] as String,
    startTime: json['start_time'] as String,
    estimatedCompleteTime: json['estimated_complete_time'] as String,
  );
}

Map<String, dynamic> _$MultiDaySlotEntityToJson(MultiDaySlotEntity instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'time': instance.time,
      'start_time': instance.startTime,
      'estimated_complete_time': instance.estimatedCompleteTime,
    };
