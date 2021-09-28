import 'package:json_annotation/json_annotation.dart';
part 'vehicle_brand.g.dart';

class VehicleBrand {
  final String name;
  final String imageUrl;
  final String? description;
  VehicleBrand({
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory VehicleBrand.fromEntity(VehicleBrandEntity entity) {
    return VehicleBrand(
        name: entity.name,
        imageUrl: entity.imageUrl,
        description: entity.description);
  }
}

@JsonSerializable()
class VehicleBrandEntity {
  final String name;
  @JsonKey(name: 'image')
  final String imageUrl;
  final String? description;
  VehicleBrandEntity({
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory VehicleBrandEntity.fromJson(Map<String, dynamic> data) =>
      _$VehicleBrandEntityFromJson(data);

  Map<String, dynamic> toJson() => _$VehicleBrandEntityToJson(this);
}
