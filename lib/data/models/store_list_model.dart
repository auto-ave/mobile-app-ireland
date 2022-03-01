import 'package:json_annotation/json_annotation.dart';

import 'package:themotorwash/data/models/price_time_list_model.dart';

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
  final List<PriceTimeListModel>? taggedServices;

  StoreListModel(
      {required this.name,
      this.distance,
      this.rating,
      this.servicesStart,
      this.thumbnail,
      this.storeSlug,
      this.images,
      this.address,
      required this.taggedServices});

  factory StoreListModel.fromEntity(StoreListEntity e) {
    return StoreListModel(
        name: e.name,
        distance: e.distance,
        rating: e.rating,
        servicesStart: e.servicesStart.toString(),
        thumbnail: e.thumbnail,
        storeSlug: e.storeSlug,
        images: e.images,
        address: e.address,
        taggedServices: e.taggedServices != null
            ? e.taggedServices!
                .map((e) => PriceTimeListModel.fromEntity(e))
                .toList()
            : null);
  }

  @override
  String toString() {
    return 'StoreListModel(name: $name, distance: $distance, rating: $rating, servicesStart: $servicesStart, thumbnail: $thumbnail, storeSlug: $storeSlug, images: $images, address: $address, taggedServices: $taggedServices)';
  }
}

@JsonSerializable(explicitToJson: true)
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
  @JsonKey(name: 'tagged_services')
  final List<PriceTimeListEntity>? taggedServices;

  StoreListEntity(
      {required this.name,
      this.distance,
      this.rating,
      this.servicesStart,
      this.thumbnail,
      this.storeSlug,
      this.images,
      this.address,
      required this.taggedServices});

  factory StoreListEntity.fromJson(Map<String, dynamic> data) =>
      _$StoreListEntityFromJson(data);

  Map<String, dynamic> toJson() => _$StoreListEntityToJson(this);
}
