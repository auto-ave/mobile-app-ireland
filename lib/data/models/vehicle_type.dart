import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_type.g.dart';

@HiveType(typeId: 1)
class VehicleTypeModel extends HiveObject {
  @HiveField(0)
  final String model;
  @HiveField(1)
  final String wheel;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String? image;
  VehicleTypeModel({
    required this.model,
    required this.wheel,
    required this.description,
    required this.image,
  });

  factory VehicleTypeModel.fromEntity(VehicleTypeEntity e) {
    return VehicleTypeModel(
        model: e.model,
        wheel: e.wheel,
        description: e.description,
        image: e.image);
  }

  @override
  String toString() {
    return 'VehicleTypeModel(model: $model, wheel: $wheel, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleTypeModel &&
        other.model == model &&
        other.wheel == wheel &&
        other.description == description &&
        other.image == image;
  }

  @override
  int get hashCode {
    return model.hashCode ^
        wheel.hashCode ^
        description.hashCode ^
        image.hashCode;
  }
}

@JsonSerializable()
class VehicleTypeEntity {
  final String model;
  final String wheel;
  final String? description;
  final String? image;
  VehicleTypeEntity({
    required this.model,
    required this.wheel,
    required this.description,
    required this.image,
  });

  factory VehicleTypeEntity.fromJson(Map<String, dynamic> data) =>
      _$VehicleTypeEntityFromJson(data);

  Map<String, dynamic> toJson() => _$VehicleTypeEntityToJson(this);

  @override
  String toString() {
    return 'VehicleTypeEntity(model: $model, wheel: $wheel, description: $description, image: $image)';
  }
}
