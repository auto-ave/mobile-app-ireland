import 'package:json_annotation/json_annotation.dart';
part 'multi_day_slot.g.dart';

class MultiDaySlot {
  final String image;
  final String title;
  final String time;
  final String startTime;

  final String estimatedCompleteTime;

  MultiDaySlot(
      {required this.image,
      required this.title,
      required this.time,
      required this.startTime,
      required this.estimatedCompleteTime});
  factory MultiDaySlot.fromEntity(MultiDaySlotEntity entity) {
    return MultiDaySlot(
        image: entity.image,
        title: entity.title,
        time: entity.time,
        startTime: entity.startTime,
        estimatedCompleteTime: entity.estimatedCompleteTime);
  }
}

@JsonSerializable()
class MultiDaySlotEntity {
  final String image;
  final String title;
  final String time;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'estimated_complete_time')
  final String estimatedCompleteTime;
  MultiDaySlotEntity(
      {required this.image,
      required this.title,
      required this.time,
      required this.startTime,
      required this.estimatedCompleteTime});
  factory MultiDaySlotEntity.fromJson(Map<String, dynamic> data) =>
      _$MultiDaySlotEntityFromJson(data);

  Map<String, dynamic> toJson() => _$MultiDaySlotEntityToJson(this);
}
