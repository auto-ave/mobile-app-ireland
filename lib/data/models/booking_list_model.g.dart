// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingListEntity _$BookingListEntityFromJson(Map<String, dynamic> json) {
  return BookingListEntity(
    id: json['id'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    bookingId: json['booking_id'] as String?,
    status: json['booking_status'] as String?,
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
    serviceNames: (json['price_times'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    amount: json['amount'] as String?,
    review: json['review'] == null
        ? null
        : ReviewEntity.fromJson(json['review'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookingListEntityToJson(BookingListEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'booking_id': instance.bookingId,
      'booking_status': instance.status,
      'status_changed_time': instance.statusChangedTime,
      'otp': instance.otp,
      'event': instance.event?.toJson(),
      'vehicle_type': instance.vehicleType,
      'store': instance.store?.toJson(),
      'booked_by': instance.bookedBy,
      'is_refunded': instance.isRefunded,
      'price_times': instance.serviceNames,
      'amount': instance.amount,
      'review': instance.review?.toJson(),
    };
