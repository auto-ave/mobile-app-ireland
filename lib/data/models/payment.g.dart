// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentEntity _$PaymentEntityFromJson(Map<String, dynamic> json) {
  return PaymentEntity(
    id: json['id'] as int?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    paymentStatus: json['payment_status'] as int?,
    modeOfPayment: json['mode_of_payment'] as String?,
    amount: json['amount'] as int?,
    booking: json['booking'] as int?,
  );
}

Map<String, dynamic> _$PaymentEntityToJson(PaymentEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'payment_status': instance.paymentStatus,
      'mode_of_payment': instance.modeOfPayment,
      'amount': instance.amount,
      'booking': instance.booking,
    };
