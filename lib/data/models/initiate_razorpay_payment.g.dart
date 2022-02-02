// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_razorpay_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiateRazorpayPaymentEntity _$InitiateRazorpayPaymentEntityFromJson(
    Map<String, dynamic> json) {
  return InitiateRazorpayPaymentEntity(
    bookingId: json['booking_id'] as String,
    key: json['key'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    timeout: json['timeout'] as int,
    prefill: PrefillModel.fromJson(json['prefill'] as Map<String, dynamic>),
    amount: json['amount'] as int,
    orderId: json['order_id'] as String,
    theme: RazorpayTheme.fromJson(json['theme'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InitiateRazorpayPaymentEntityToJson(
        InitiateRazorpayPaymentEntity instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'description': instance.description,
      'timeout': instance.timeout,
      'booking_id': instance.bookingId,
      'prefill': instance.prefill.toJson(),
      'theme': instance.theme.toJson(),
      'amount': instance.amount,
      'order_id': instance.orderId,
    };

PrefillModel _$PrefillModelFromJson(Map<String, dynamic> json) {
  return PrefillModel(
    contact: json['contact'] as String?,
    email: json['email'] as String?,
  );
}

Map<String, dynamic> _$PrefillModelToJson(PrefillModel instance) =>
    <String, dynamic>{
      'contact': instance.contact,
      'email': instance.email,
    };

RazorpayTheme _$RazorpayThemeFromJson(Map<String, dynamic> json) {
  return RazorpayTheme(
    color: json['color'] as String?,
  );
}

Map<String, dynamic> _$RazorpayThemeToJson(RazorpayTheme instance) =>
    <String, dynamic>{
      'color': instance.color,
    };
