import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

class EventModel {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isBlocking;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int? bay;
  EventModel({
    required this.id,
    required this.updatedAt,
    required this.isBlocking,
    required this.startDateTime,
    required this.endDateTime,
    required this.bay,
    required this.createdAt,
  });

  factory EventModel.fromEntity(EventEntity e) {
    return EventModel(
        id: e.id,
        updatedAt: DateTime.parse(e.updatedAt),
        isBlocking: e.isBlocking,
        startDateTime: DateTime.parse(e.startDateTime),
        endDateTime: DateTime.parse(e.endDateTime),
        bay: e.bay,
        createdAt: DateTime.parse(e.createdAt));
  }

  @override
  String toString() {
    return 'EventModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, isBlocking: $isBlocking, startDateTime: $startDateTime, endDateTime: $endDateTime, bay: $bay)';
  }
}

@JsonSerializable()
class EventEntity {
  final int id;
  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @JsonKey(name: 'is_blocking')
  final bool isBlocking;

  @JsonKey(name: 'start_datetime')
  final String startDateTime;

  @JsonKey(name: 'end_datetime')
  final String endDateTime;
  final int? bay;
  EventEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.isBlocking,
    required this.startDateTime,
    required this.endDateTime,
    this.bay,
  });

  factory EventEntity.fromJson(Map<String, dynamic> data) =>
      _$EventEntityFromJson(data);

  Map<String, dynamic> toJson() => _$EventEntityToJson(this);
}
