// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlotEntity _$SlotEntityFromJson(Map<String, dynamic> json) {
  return SlotEntity(
    start: json['start'] as String?,
    end: json['end'] as String?,
    key: json['key'] as int?,
    bays: (json['bay_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$SlotEntityToJson(SlotEntity instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'bay_ids': instance.bays,
      'key': instance.key,
    };
