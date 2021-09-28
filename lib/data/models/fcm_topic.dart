import 'package:json_annotation/json_annotation.dart';
part 'fcm_topic.g.dart';

class FcmTopic {
  final String topic;
  final String name;
  final String description;
  FcmTopic({
    required this.topic,
    required this.name,
    required this.description,
  });

  factory FcmTopic.fromEntity(FcmTopicEntity entity) {
    return FcmTopic(
        topic: entity.topic,
        name: entity.name,
        description: entity.description);
  }
}

@JsonSerializable()
class FcmTopicEntity {
  @JsonKey(name: 'code')
  final String topic;
  final String name;
  final String description;
  FcmTopicEntity({
    required this.topic,
    required this.name,
    required this.description,
  });
  factory FcmTopicEntity.fromJson(Map<String, dynamic> data) =>
      _$FcmTopicEntityFromJson(data);

  Map<String, dynamic> toJson() => _$FcmTopicEntityToJson(this);
}
