// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paytm_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaytmPaymentResponseEntity _$PaytmPaymentResponseEntityFromJson(
    Map<String, dynamic> json) {
  return PaytmPaymentResponseEntity(
    currency: json['CURRENCY'] as String?,
    gatewayName: json['GATEWAYNAME'] as String?,
    responseMessage: json['RESPMSG'] as String?,
    bankName: json['BANKNAME'] as String?,
    paymentMode: json['PAYMENTMODE'] as String?,
    mid: json['MID'] as String?,
    responseCode: json['RESPCODE'] as String?,
    transactionAmount: json['TXNAMOUNT'] as String?,
    transactionId: json['TXNID'] as String?,
    orderId: json['ORDERID'] as String?,
    bankTransactionId: json['BANKTXNID'] as String?,
    status: json['STATUS'] as String?,
    transactionDate: json['TXNDATE'] as String?,
    checksumHash: json['CHECKSUMHASH'] as String?,
  );
}

Map<String, dynamic> _$PaytmPaymentResponseEntityToJson(
        PaytmPaymentResponseEntity instance) =>
    <String, dynamic>{
      'CURRENCY': instance.currency,
      'GATEWAYNAME': instance.gatewayName,
      'RESPMSG': instance.responseMessage,
      'BANKNAME': instance.bankName,
      'PAYMENTMODE': instance.paymentMode,
      'MID': instance.mid,
      'RESPCODE': instance.responseCode,
      'TXNAMOUNT': instance.transactionAmount,
      'TXNID': instance.transactionId,
      'ORDERID': instance.orderId,
      'BANKTXNID': instance.bankTransactionId,
      'STATUS': instance.status,
      'TXNDATE': instance.transactionDate,
      'CHECKSUMHASH': instance.checksumHash,
    };
