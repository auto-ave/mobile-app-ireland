import 'package:json_annotation/json_annotation.dart';

part 'paytm_payment_response.g.dart';

class PaytmPaymentResponseModel {
  final String? currency;
  final String? gatewayName;
  final String? responseMessage;
  final String? bankName;
  final String? paymentMode;
  final String? mid;
  final String? responseCode;
  final String? transactionAmount;
  final String? transactionId;
  final String? orderId;
  final String? bankTransactionId;
  final String? status;
  final DateTime? transactionDate;
  final String? checksumHash;
  final String? transactionDateString;
  PaytmPaymentResponseModel(
      {required this.currency,
      required this.gatewayName,
      required this.responseMessage,
      required this.bankName,
      required this.paymentMode,
      required this.mid,
      required this.responseCode,
      required this.transactionAmount,
      required this.transactionId,
      required this.orderId,
      required this.bankTransactionId,
      required this.status,
      required this.transactionDate,
      required this.checksumHash,
      required this.transactionDateString});

  factory PaytmPaymentResponseModel.fromEntity(PaytmPaymentResponseEntity e) {
    return PaytmPaymentResponseModel(
        currency: e.currency,
        gatewayName: e.gatewayName,
        responseMessage: e.responseMessage,
        bankName: e.bankName,
        paymentMode: e.paymentMode,
        mid: e.mid,
        responseCode: e.responseCode,
        transactionAmount: e.transactionAmount,
        transactionId: e.transactionId,
        orderId: e.orderId,
        bankTransactionId: e.bankTransactionId,
        status: e.status,
        transactionDate: e.transactionDate != null
            ? DateTime.parse(e.transactionDate!)
            : null,
        transactionDateString: e.transactionDate,
        checksumHash: e.checksumHash);
  }

  PaytmPaymentResponseEntity toEntity() {
    return PaytmPaymentResponseEntity(
        currency: currency,
        gatewayName: gatewayName,
        responseMessage: responseMessage,
        bankName: bankName,
        paymentMode: paymentMode,
        mid: mid,
        responseCode: responseCode,
        transactionAmount: transactionAmount,
        transactionId: transactionId,
        orderId: orderId,
        bankTransactionId: bankTransactionId,
        status: status,
        transactionDate: transactionDateString,
        checksumHash: checksumHash);
  }

  @override
  String toString() {
    return 'PaytmPaymentResponseModel(currency: $currency, gatewayName: $gatewayName, responseMessage: $responseMessage, bankName: $bankName, paymentMode: $paymentMode, mid: $mid, responseCode: $responseCode, transactionAmount: $transactionAmount, transactionId: $transactionId, orderId: $orderId, bankTransactionId: $bankTransactionId, status: $status, transactionDate: $transactionDate, checksumHash: $checksumHash)';
  }
}

@JsonSerializable()
class PaytmPaymentResponseEntity {
  @JsonKey(name: 'CURRENCY')
  final String? currency;
  @JsonKey(name: 'GATEWAYNAME')
  final String? gatewayName;
  @JsonKey(name: 'RESPMSG')
  final String? responseMessage;
  @JsonKey(name: 'BANKNAME')
  final String? bankName;
  @JsonKey(name: 'PAYMENTMODE')
  final String? paymentMode;
  @JsonKey(name: 'MID')
  final String? mid;
  @JsonKey(name: 'RESPCODE')
  final String? responseCode;
  @JsonKey(name: 'TXNAMOUNT')
  final String? transactionAmount;
  @JsonKey(name: 'TXNID')
  final String? transactionId;
  @JsonKey(name: 'ORDERID')
  final String? orderId;
  @JsonKey(name: 'BANKTXNID')
  final String? bankTransactionId;
  @JsonKey(name: 'STATUS')
  final String? status;
  @JsonKey(name: 'TXNDATE')
  final String? transactionDate;
  @JsonKey(name: 'CHECKSUMHASH')
  final String? checksumHash;
  PaytmPaymentResponseEntity({
    required this.currency,
    required this.gatewayName,
    required this.responseMessage,
    required this.bankName,
    required this.paymentMode,
    required this.mid,
    required this.responseCode,
    required this.transactionAmount,
    required this.transactionId,
    required this.orderId,
    required this.bankTransactionId,
    required this.status,
    required this.transactionDate,
    required this.checksumHash,
  });
  factory PaytmPaymentResponseEntity.fromJson(Map<String, dynamic> data) =>
      _$PaytmPaymentResponseEntityFromJson(data);

  Map<String, dynamic> toJson() => _$PaytmPaymentResponseEntityToJson(this);

  @override
  String toString() {
    return 'PaytmPaymentResponseEntity(currency: $currency, gatewayName: $gatewayName, responseMessage: $responseMessage, bankName: $bankName, paymentMode: $paymentMode, mid: $mid, responseCode: $responseCode, transactionAmount: $transactionAmount, transactionId: $transactionId, orderId: $orderId, bankTransactionId: $bankTransactionId, status: $status, transactionDate: $transactionDate, checksumHash: $checksumHash)';
  }
}
