// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'razorpay_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RazorpayPaymentResponseEntity _$RazorpayPaymentResponseEntityFromJson(
    Map<String, dynamic> json) {
  return RazorpayPaymentResponseEntity(
    razorpayPaymentId: json['razorpay_payment_id'] as String,
    razorpayOrderId: json['razorpay_order_id'] as String,
    razorpaySignature: json['razorpay_signature'] as String,
  );
}

Map<String, dynamic> _$RazorpayPaymentResponseEntityToJson(
        RazorpayPaymentResponseEntity instance) =>
    <String, dynamic>{
      'razorpay_payment_id': instance.razorpayPaymentId,
      'razorpay_order_id': instance.razorpayOrderId,
      'razorpay_signature': instance.razorpaySignature,
    };
