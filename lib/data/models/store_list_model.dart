import 'package:json_annotation/json_annotation.dart';

part 'store_list_model.g.dart';

class StoreListModel {
  final String name;
  final String? distance;
  final String? rating;
  final String? servicesStart;
  final String? thumbnail;
  final String? storeSlug;
  StoreListModel(
      {required this.name,
      this.distance,
      this.rating,
      this.servicesStart,
      this.thumbnail,
      this.storeSlug});

  factory StoreListModel.fromEntity(StoreListEntity e) {
    return StoreListModel(
        name: e.name,
        distance: e.distance,
        rating: e.rating,
        servicesStart: e.servicesStart.toString(),
        thumbnail: e.thumbnail,
        storeSlug: e.storeSlug);
  }

  @override
  String toString() {
    return 'StoreListModel(name: $name, distance: $distance, rating: $rating, servicesStart: $servicesStart, thumbnail: $thumbnail, storeSlug: $storeSlug)';
  }
}

@JsonSerializable()
class StoreListEntity {
  final String name;
  final String? distance;
  final String? rating;

  @JsonKey(name: 'services_start')
  final int? servicesStart;
  final String? thumbnail;

  @JsonKey(name: 'slug')
  final String? storeSlug;

  StoreListEntity(
      {required this.name,
      this.distance,
      this.rating,
      this.servicesStart,
      this.thumbnail,
      this.storeSlug});

  factory StoreListEntity.fromJson(Map<String, dynamic> data) =>
      _$StoreListEntityFromJson(data);

  Map<String, dynamic> toJson() => _$StoreListEntityToJson(this);
}
