// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_booking_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelBookingDataEntity _$CancelBookingDataEntityFromJson(
    Map<String, dynamic> json) {
  return CancelBookingDataEntity(
    reasons:
        (json['reasons'] as List<dynamic>).map((e) => e as String).toList(),
    refundAmount: json['refund_amount'] as num,
    isRefundable: json['is_refundable'] as bool,
  );
}

Map<String, dynamic> _$CancelBookingDataEntityToJson(
        CancelBookingDataEntity instance) =>
    <String, dynamic>{
      'reasons': instance.reasons,
      'refund_amount': instance.refundAmount,
      'is_refundable': instance.isRefundable,
    };
