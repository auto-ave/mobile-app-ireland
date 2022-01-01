import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:themotorwash/utils/utils.dart';

part 'slot.g.dart';

class Slot {
  final TimeOfDay? start;
  final TimeOfDay? end;
  final String? startString;
  final String? endString;
  final int? count;
  final int? key;
  final List<int>? bays;

  Slot(
      {required this.start,
      required this.end,
      required this.count,
      required this.key,
      required this.bays,
      required this.endString,
      required this.startString});

  factory Slot.fromEntity(SlotEntity e) {
    return Slot(
        start: e.start != null ? getTimeOfDayFromString(e.start!) : null,
        end: e.end != null ? getTimeOfDayFromString(e.end!) : null,
        count: e.bays!.length,
        key: e.key,
        bays: e.bays,
        endString: e.end,
        startString: e.start);
  }

  @override
  String toString() {
    return 'Slot(start: $start, end: $end, count: $count, key: $key, bays: $bays)';
  }
}

@JsonSerializable()
class SlotEntity {
  final String? start;
  final String? end;
  @JsonKey(name: 'bay_ids')
  final List<int>? bays;
  final int? key;
  SlotEntity(
      {required this.start,
      required this.end,
      required this.key,
      required this.bays});
  factory SlotEntity.fromJson(Map<String, dynamic> data) =>
      _$SlotEntityFromJson(data);

  Map<String, dynamic> toJson() => _$SlotEntityToJson(this);

  @override
  String toString() {
    return 'SlotEntity(start: $start, end: $end, bays: $bays, key: $key)';
  }
}
