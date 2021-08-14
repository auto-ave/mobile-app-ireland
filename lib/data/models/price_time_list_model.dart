import 'package:json_annotation/json_annotation.dart';

part 'price_time_list_model.g.dart';

class PriceTimeListModel {
  final int? id;

  final service;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final int? price;

  final int? timeInterval;

  final String? description;

  final int? store;

  final int? vehicleType;

  final List<int>? bays;
  PriceTimeListModel({
    this.id,
    this.service,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.timeInterval,
    this.description,
    this.store,
    this.vehicleType,
    this.bays,
  });

  factory PriceTimeListModel.fromEntity(PriceTimeListEntity entity) {
    return PriceTimeListModel(
        bays: entity.bays,
        id: entity.id,
        price: entity.price,
        store: entity.store,
        service: entity.service,
        vehicleType: entity.vehicleType,
        timeInterval: entity.timeInterval,
        description: entity.description,
        createdAt: DateTime.parse(entity.createdAt!),
        updatedAt: DateTime.parse(entity.updatedAt!));
  }
}

@JsonSerializable()
class PriceTimeListEntity {
  final int? id;

  final service; //TODO : typee

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  final int? price;

  @JsonKey(name: 'time_interval')
  final int? timeInterval;

  final String? description;

  final int? store;

  @JsonKey(name: 'vehicle_type')
  final int? vehicleType;

  final List<int>? bays;
  PriceTimeListEntity({
    this.id,
    this.service,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.timeInterval,
    this.description,
    this.store,
    this.vehicleType,
    this.bays,
  });

  factory PriceTimeListEntity.fromJson(Map<String, dynamic> data) =>
      _$PriceTimeListEntityFromJson(data);

  Map<String, dynamic> toJson() => _$PriceTimeListEntityToJson(this);
}
