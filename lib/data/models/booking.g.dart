// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingEntity _$BookingEntityFromJson(Map<String, dynamic> json) {
  return BookingEntity(
    id: json['id'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    bookingId: json['booking_id'] as String?,
    status: json['status'] as int?,
    statusChangedTime: json['status_changed_time'] as String?,
    otp: json['otp'] as String?,
    event: json['event'] as int?,
    vehicleType: json['vehicle_type'] as int?,
    store: json['store'] as int?,
    bookedBy: json['booked_by'] as int?,
    isRefunded: json['is_refunded'] as bool?,
    serviceNames: (json['price_times'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    amount: json['amount'] as int?,
  );
}

Map<String, dynamic> _$BookingEntityToJson(BookingEntity instance) =>
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
      'store': instance.store,
      'booked_by': instance.bookedBy,
      'is_refunded': instance.isRefunded,
      'price_times': instance.serviceNames,
      'amount': instance.amount,
    };
