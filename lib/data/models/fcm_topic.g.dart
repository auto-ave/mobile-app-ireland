// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmTopicEntity _$FcmTopicEntityFromJson(Map<String, dynamic> json) {
  return FcmTopicEntity(
    topic: json['code'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$FcmTopicEntityToJson(FcmTopicEntity instance) =>
    <String, dynamic>{
      'code': instance.topic,
      'name': instance.name,
      'description': instance.description,
    };
