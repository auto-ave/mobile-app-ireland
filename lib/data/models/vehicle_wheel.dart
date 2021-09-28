import 'package:json_annotation/json_annotation.dart';

part 'vehicle_wheel.g.dart';

class VehicleWheel {
  final String code;
  final String name;
  final String imageUrl;
  VehicleWheel({
    required this.code,
    required this.name,
    required this.imageUrl,
  });

  factory VehicleWheel.fromEntity(VehicleWheelEntity entity) {
    return VehicleWheel(
        code: entity.code, name: entity.name, imageUrl: entity.imageUrl);
  }
}

@JsonSerializable()
class VehicleWheelEntity {
  final String code;
  final String name;
  @JsonKey(name: 'image')
  final String imageUrl;
  VehicleWheelEntity({
    required this.code,
    required this.name,
    required this.imageUrl,
  });
  factory VehicleWheelEntity.fromJson(Map<String, dynamic> data) =>
      _$VehicleWheelEntityFromJson(data);

  Map<String, dynamic> toJson() => _$VehicleWheelEntityToJson(this);
}
