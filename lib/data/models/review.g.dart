// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewEntity _$ReviewEntityFromJson(Map<String, dynamic> json) {
  return ReviewEntity(
    id: json['id'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    isOnlyRating: json['is_only_rating'] as bool?,
    reviewDescription: json['review_description'] as String?,
    rating: json['rating'] as String?,
    consumerId: json['consumer'] as int?,
    bookingId: json['booking'] as String?,
    store: json['store'] as int?,
    customerName: json['user'] as String?,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$ReviewEntityToJson(ReviewEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.customerName,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_only_rating': instance.isOnlyRating,
      'review_description': instance.reviewDescription,
      'rating': instance.rating,
      'consumer': instance.consumerId,
      'booking': instance.bookingId,
      'store': instance.store,
      'image': instance.image,
    };
