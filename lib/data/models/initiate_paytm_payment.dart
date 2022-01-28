import 'package:json_annotation/json_annotation.dart';

part 'initiate_paytm_payment.g.dart';

class InitiatePaytmPaymentModel {
  final String mid;
  final String orderId;
  final String amount;
  final String callbackUrl;
  final String transactionToken;
  InitiatePaytmPaymentModel({
    required this.mid,
    required this.orderId,
    required this.amount,
    required this.callbackUrl,
    required this.transactionToken,
  });

  factory InitiatePaytmPaymentModel.fromEntity(InitiatePaytmPaymentEntity e) {
    return InitiatePaytmPaymentModel(
        mid: e.mid,
        orderId: e.orderId,
        amount: e.amount,
        callbackUrl: e.callbackUrl,
        transactionToken: e.transactionToken);
  }

  @override
  String toString() {
    return 'InitiatePaymentModel(mid: $mid, orderId: $orderId, amount: $amount, callbackUrl: $callbackUrl, transactionToken: $transactionToken)';
  }
}

@JsonSerializable()
class InitiatePaytmPaymentEntity {
  final String mid;
  @JsonKey(name: 'order_id')
  final String orderId;
  final String amount;
  @JsonKey(name: 'callback_url')
  final String callbackUrl;
  @JsonKey(name: 'txn_token')
  final String transactionToken;
  InitiatePaytmPaymentEntity({
    required this.mid,
    required this.orderId,
    required this.amount,
    required this.callbackUrl,
    required this.transactionToken,
  });
  factory InitiatePaytmPaymentEntity.fromJson(Map<String, dynamic> data) =>
      _$InitiatePaytmPaymentEntityFromJson(data);

  Map<String, dynamic> toJson() => _$InitiatePaytmPaymentEntityToJson(this);

  @override
  String toString() {
    return 'InitiatePaymentEntity(mid: $mid, orderId: $orderId, amount: $amount, callbackUrl: $callbackUrl, transactionToken: $transactionToken)';
  }
}
