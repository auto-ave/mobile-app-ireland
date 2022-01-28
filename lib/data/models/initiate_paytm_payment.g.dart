// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initiate_paytm_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitiatePaytmPaymentEntity _$InitiatePaytmPaymentEntityFromJson(
    Map<String, dynamic> json) {
  return InitiatePaytmPaymentEntity(
    mid: json['mid'] as String,
    orderId: json['order_id'] as String,
    amount: json['amount'] as String,
    callbackUrl: json['callback_url'] as String,
    transactionToken: json['txn_token'] as String,
  );
}

Map<String, dynamic> _$InitiatePaytmPaymentEntityToJson(
        InitiatePaytmPaymentEntity instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'order_id': instance.orderId,
      'amount': instance.amount,
      'callback_url': instance.callbackUrl,
      'txn_token': instance.transactionToken,
    };
