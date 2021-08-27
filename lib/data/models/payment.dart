import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

class PaymentModel {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? paymentStatus;
  final String? modeOfPayment;
  final String? amount;
  final String? booking;
  PaymentModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.paymentStatus,
    this.modeOfPayment,
    this.amount,
    this.booking,
  });
  factory PaymentModel.fromEntity(PaymentEntity e) {
    return PaymentModel(
        id: e.id,
        amount: e.amount,
        booking: e.booking,
        createdAt: DateTime.parse(e.createdAt),
        updatedAt: DateTime.parse(e.updatedAt),
        modeOfPayment: e.modeOfPayment,
        paymentStatus: e.paymentStatus);
  }
}

@JsonSerializable()
class PaymentEntity {
  final int id;
  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @JsonKey(name: 'payment_status')
  final String? paymentStatus;

  @JsonKey(name: 'mode_of_payment')
  final String? modeOfPayment;
  final String? amount;
  final String? booking;
  PaymentEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.paymentStatus,
    this.modeOfPayment,
    this.amount,
    this.booking,
  });
  factory PaymentEntity.fromJson(Map<String, dynamic> data) =>
      _$PaymentEntityFromJson(data);

  Map<String, dynamic> toJson() => _$PaymentEntityToJson(this);
}
