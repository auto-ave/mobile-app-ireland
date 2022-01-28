import 'package:json_annotation/json_annotation.dart';

import 'package:themotorwash/data/models/multi_day_slot.dart';

part 'multi_day_slot_detail.g.dart';

class MultiDaySlotDetailModel {
  final String? delayMessage;
  final List<MultiDaySlot> slots;

  MultiDaySlotDetailModel({
    required this.slots,
    this.delayMessage,
  });
  factory MultiDaySlotDetailModel.fromEntity(MultiDaySlotDetailEntity entity) {
    return MultiDaySlotDetailModel(
      delayMessage: entity.delayMessage,
      slots: entity.slots.map((e) => MultiDaySlot.fromEntity(e)).toList(),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MultiDaySlotDetailEntity {
  @JsonKey(name: 'delay_message')
  final String? delayMessage;
  @JsonKey(name: 'slots')
  final List<MultiDaySlotEntity> slots;

  MultiDaySlotDetailEntity({
    this.delayMessage,
    required this.slots,
  });

  factory MultiDaySlotDetailEntity.fromJson(Map<String, dynamic> data) =>
      _$MultiDaySlotDetailEntityFromJson(data);

  Map<String, dynamic> toJson() => _$MultiDaySlotDetailEntityToJson(this);
}
