import 'package:json_annotation/json_annotation.dart';

part 'offer.g.dart';

class OfferModel {
  final num? id;
  final String? code;
  final String? title;
  final String? description;
  final String? bannerUrl;

  OfferModel(
      {required this.id,
      required this.code,
      required this.title,
      required this.description,
      required this.bannerUrl});
  factory OfferModel.fromEntity(OfferEntity e) {
    return OfferModel(
        id: e.id,
        code: e.code,
        title: e.title,
        description: e.description,
        bannerUrl: e.banner);
  }

  @override
  String toString() {
    return 'OfferModel(id: $id, code: $code, title: $title, description: $description, bannerUrl: $bannerUrl)';
  }
}

@JsonSerializable()
class OfferEntity {
  final num? id;
  final String? code;
  final String? title;
  final String? description;
  final String? banner;
  OfferEntity(
      {required this.id,
      required this.code,
      required this.title,
      required this.description,
      required this.banner});
  factory OfferEntity.fromJson(Map<String, dynamic> data) =>
      _$OfferEntityFromJson(data);

  Map<String, dynamic> toJson() => _$OfferEntityToJson(this);

  @override
  String toString() {
    return 'OfferEntity(id: $id, banner:$banner, code: $code, title: $title, description: $description)';
  }
}