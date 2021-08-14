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
    status: json['status'] as int?,
    statusChangedTime: json['status_changed_time'] as String?,
    otp: json['otp'] as String?,
    event: json['event'] as int?,
    vehicleType: json['vehicle_type'] as int?,
    store: json['store'] == null
        ? null
        : StoreEntity.fromJson(json['store'] as Map<String, dynamic>),
    bookedBy: json['booked_by'] as int?,
    isRefunded: json['is_refunded'] as bool?,
    serviceNames: (json['price_times'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    amount: json['amount'] as int?,
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
      'status': instance.status,
      'status_changed_time': instance.statusChangedTime,
      'otp': instance.otp,
      'event': instance.event,
      'vehicle_type': instance.vehicleType,
      'store': instance.store?.toJson(),
      'booked_by': instance.bookedBy,
      'is_refunded': instance.isRefunded,
      'price_times': instance.serviceNames,
      'amount': instance.amount,
      'review': instance.review?.toJson(),
    };
