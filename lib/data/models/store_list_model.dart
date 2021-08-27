import 'package:json_annotation/json_annotation.dart';

part 'store_list_model.g.dart';

class StoreListModel {
  final String name;
  final String? distance;
  final String? rating;
  final String? servicesStart;
  final String? thumbnail;
  final String? storeSlug;
  final List<String>? images;
  final String? address;

  StoreListModel(
      {required this.name,
      this.distance,
      this.rating,
      this.servicesStart,
      this.thumbnail,
      this.storeSlug,
      this.images,
      this.address});

  factory StoreListModel.fromEntity(StoreListEntity e) {
    return StoreListModel(
        name: e.name,
        distance: e.distance,
        rating: e.rating,
        servicesStart: e.servicesStart.toString(),
        thumbnail: e.thumbnail,
        storeSlug: e.storeSlug,
        images: e.images,
        address: e.address);
  }

  @override
  String toString() {
    return 'StoreListModel(name: $name, distance: $distance, rating: $rating, servicesStart: $servicesStart, thumbnail: $thumbnail, storeSlug: $storeSlug, images: $images)';
  }
}

@JsonSerializable()
class StoreListEntity {
  final String name;
  final String? distance;
  final String? rating;
  final List<String>? images;
  @JsonKey(name: 'services_start')
  final int? servicesStart;
  final String? thumbnail;

  @JsonKey(name: 'slug')
  final String? storeSlug;

  final String? address;

  StoreListEntity(
      {required this.name,
      this.distance,
      this.rating,
      this.servicesStart,
      this.thumbnail,
      this.storeSlug,
      this.images,
      this.address});

  factory StoreListEntity.fromJson(Map<String, dynamic> data) =>
      _$StoreListEntityFromJson(data);

  Map<String, dynamic> toJson() => _$StoreListEntityToJson(this);
}
