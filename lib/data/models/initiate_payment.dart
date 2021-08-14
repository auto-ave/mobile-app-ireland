import 'package:json_annotation/json_annotation.dart';

part 'initiate_payment.g.dart';

class InitiatePaymentModel {
  final String mid;
  final String orderId;
  final String amount;
  final String callbackUrl;
  final String transactionToken;
  InitiatePaymentModel({
    required this.mid,
    required this.orderId,
    required this.amount,
    required this.callbackUrl,
    required this.transactionToken,
  });

  factory InitiatePaymentModel.fromEntity(InitiatePaymentEntity e) {
    return InitiatePaymentModel(
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
class InitiatePaymentEntity {
  final String mid;
  @JsonKey(name: 'order_id')
  final String orderId;
  final String amount;
  @JsonKey(name: 'callback_url')
  final String callbackUrl;
  @JsonKey(name: 'txn_token')
  final String transactionToken;
  InitiatePaymentEntity({
    required this.mid,
    required this.orderId,
    required this.amount,
    required this.callbackUrl,
    required this.transactionToken,
  });
  factory InitiatePaymentEntity.fromJson(Map<String, dynamic> data) =>
      _$InitiatePaymentEntityFromJson(data);

  Map<String, dynamic> toJson() => _$InitiatePaymentEntityToJson(this);

  @override
  String toString() {
    return 'InitiatePaymentEntity(mid: $mid, orderId: $orderId, amount: $amount, callbackUrl: $callbackUrl, transactionToken: $transactionToken)';
  }
}
