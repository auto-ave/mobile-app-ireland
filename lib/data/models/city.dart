import 'package:json_annotation/json_annotation.dart';
part 'city.g.dart';

class City {
  final String code;
  final String name;
  final String latitude;
  final String longitude;
  City({
    required this.code,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory City.fromEntity(CityEntity entity) {
    return City(
        code: entity.code,
        name: entity.name,
        latitude: entity.latitude,
        longitude: entity.longitude);
  }
}

@JsonSerializable()
class CityEntity {
  final String code;
  final String name;
  final String latitude;
  final String longitude;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  CityEntity({
    required this.code,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CityEntity.fromJson(Map<String, dynamic> data) =>
      _$CityEntityFromJson(data);

  Map<String, dynamic> toJson() => _$CityEntityToJson(this);
}
