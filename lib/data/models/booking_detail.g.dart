// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingDetailEntity _$BookingDetailEntityFromJson(Map<String, dynamic> json) {
  return BookingDetailEntity(
    id: json['id'] as int?,
    bookingId: json['booking_id'] as String?,
    payment: json['payment'] == null
        ? null
        : PaymentEntity.fromJson(json['payment'] as Map<String, dynamic>),
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    status: json['status'] as int?,
    amount: json['amount'] as String?,
    statusChangedTime: json['status_changed_time'] as String?,
    otp: json['otp'] as String?,
    event: json['event'] == null
        ? null
        : EventEntity.fromJson(json['event'] as Map<String, dynamic>),
    vehicleType: json['vehicle_type'] as String?,
    store: json['store'] == null
        ? null
        : StoreEntity.fromJson(json['store'] as Map<String, dynamic>),
    bookedBy: json['booked_by'] as int?,
    isRefunded: json['is_refunded'] as bool?,
    services: (json['price_times'] as List<dynamic>?)
        ?.map((e) => PriceTimeListEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
    review: json['review'] == null
        ? null
        : ReviewEntity.fromJson(json['review'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookingDetailEntityToJson(
        BookingDetailEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_id': instance.bookingId,
      'payment': instance.payment?.toJson(),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'status': instance.status,
      'amount': instance.amount,
      'status_changed_time': instance.statusChangedTime,
      'otp': instance.otp,
      'event': instance.event?.toJson(),
      'vehicle_type': instance.vehicleType,
      'store': instance.store?.toJson(),
      'booked_by': instance.bookedBy,
      'is_refunded': instance.isRefunded,
      'price_times': instance.services?.map((e) => e.toJson()).toList(),
      'review': instance.review?.toJson(),
    };
