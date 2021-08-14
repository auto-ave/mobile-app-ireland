// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiatePaymentEntity _$InitiatePaymentEntityFromJson(
    Map<String, dynamic> json) {
  return InitiatePaymentEntity(
    mid: json['mid'] as String,
    orderId: json['order_id'] as String,
    amount: json['amount'] as String,
    callbackUrl: json['callback_url'] as String,
    transactionToken: json['txn_token'] as String,
  );
}

Map<String, dynamic> _$InitiatePaymentEntityToJson(
        InitiatePaymentEntity instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'order_id': instance.orderId,
      'amount': instance.amount,
      'callback_url': instance.callbackUrl,
      'txn_token': instance.transactionToken,
    };
