import 'package:json_annotation/json_annotation.dart';

part 'offer.g.dart';

class OfferModel {
  final num? id;
  final String? code;
  final String? title;
  final String? description;
  final String? bannerUrl;
  final String? saving;
  final String? storeSlug;
  OfferModel(
      {required this.id,
      required this.code,
      required this.title,
      required this.description,
      required this.saving,
      required this.bannerUrl,
      required this.storeSlug});
  factory OfferModel.fromEntity(OfferEntity e) {
    return OfferModel(
        id: e.id,
        code: e.code,
        title: e.title,
        description: e.description,
        saving: e.saving,
        bannerUrl: e.banner,
        storeSlug: e.storeSlug);
  }

  @override
  String toString() {
    return 'OfferModel(id: $id, code: $code, title: $title, description: $description, bannerUrl: $bannerUrl, saving: $saving, storeSlug: $storeSlug)';
  }
}

@JsonSerializable()
class OfferEntity {
  final num? id;
  final String? code;
  final String? title;
  final String? description;
  final String? banner;
  final String? saving;
  @JsonKey(name: 'store_slug')
  final String? storeSlug;

  OfferEntity(
      {required this.id,
      required this.code,
      required this.title,
      required this.description,
      required this.saving,
      required this.banner,
      required this.storeSlug});
  factory OfferEntity.fromJson(Map<String, dynamic> data) =>
      _$OfferEntityFromJson(data);

  Map<String, dynamic> toJson() => _$OfferEntityToJson(this);

  @override
  String toString() {
    return 'OfferEntity(id: $id, banner:$banner, code: $code, title: $title, description: $description)';
  }
}
