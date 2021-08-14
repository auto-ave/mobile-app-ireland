import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

class Review {
  final int? id;
  final String? customerName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final bool? isOnlyRating;

  final String? reviewDescription;
  final String? rating;

  final int? consumerId;

  final int? bookingId;

  final int? storeId;
  Review({
    this.customerName,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isOnlyRating,
    this.reviewDescription,
    this.rating,
    this.consumerId,
    this.bookingId,
    this.storeId,
  });

  factory Review.fromEntity(ReviewEntity e) {
    return Review(
        customerName: e.customerName,
        rating: e.rating,
        consumerId: e.consumerId,
        bookingId: e.bookingId,
        storeId: e.storeId,
        createdAt: e.createdAt != null ? DateTime.parse(e.createdAt!) : null,
        id: e.id,
        isOnlyRating: e.isOnlyRating,
        reviewDescription: e.reviewDescription,
        updatedAt: e.updatedAt != null ? DateTime.parse(e.updatedAt!) : null);
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
        rating: this.rating,
        consumerId: this.consumerId,
        bookingId: this.bookingId,
        storeId: this.storeId,
        createdAt: this.createdAt?.toIso8601String(),
        updatedAt: this.updatedAt?.toIso8601String(),
        id: this.id,
        isOnlyRating: this.isOnlyRating,
        reviewDescription: this.reviewDescription);
  }

  @override
  String toString() {
    return 'Review(id: $id, customerName: $customerName, createdAt: $createdAt, updatedAt: $updatedAt, isOnlyRating: $isOnlyRating, reviewDescription: $reviewDescription, rating: $rating, consumerId: $consumerId, bookingId: $bookingId, storeId: $storeId)';
  }
}

@JsonSerializable()
class ReviewEntity {
  final int? id;

  @JsonKey(name: 'user')
  final String? customerName;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'is_only_rating')
  final bool? isOnlyRating;

  @JsonKey(name: 'review_description')
  final String? reviewDescription;
  final String? rating;

  @JsonKey(name: 'consumer')
  final int? consumerId;

  @JsonKey(name: 'booking')
  final int? bookingId;

  @JsonKey(name: 'store_id')
  final int? storeId;
  ReviewEntity(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isOnlyRating,
      this.reviewDescription,
      this.rating,
      this.consumerId,
      this.bookingId,
      this.storeId,
      this.customerName});

  factory ReviewEntity.fromJson(Map<String, dynamic> data) =>
      _$ReviewEntityFromJson(data);

  Map<String, dynamic> toJson() => _$ReviewEntityToJson(this);
}
