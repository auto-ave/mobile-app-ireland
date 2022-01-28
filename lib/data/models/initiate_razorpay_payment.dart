import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'initiate_razorpay_payment.g.dart';

class InitiateRazorpayPaymentModel {
  final String key;
  final String name;
  final String description;
  final int timeout;
  final PrefillModel prefill;
  final int amount;
  final String orderId;
  final String bookingId;
  final RazorpayTheme theme;
  InitiateRazorpayPaymentModel(
      {required this.key,
      required this.name,
      required this.description,
      required this.timeout,
      required this.prefill,
      required this.amount,
      required this.orderId,
      required this.bookingId,
      required this.theme});
  factory InitiateRazorpayPaymentModel.fromEntity(
      InitiateRazorpayPaymentEntity entity) {
    return InitiateRazorpayPaymentModel(
      key: entity.key,
      name: entity.name,
      description: entity.description,
      timeout: entity.timeout,
      prefill: entity.prefill,
      amount: entity.amount,
      orderId: entity.orderId,
      bookingId: entity.bookingId,
      theme: entity.theme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'name': name,
      'description': description,
      'timeout': timeout,
      'prefill': prefill.toJson(),
      'amount': amount,
      'order_id': orderId,
      'theme': theme.toJson(),
    };
  }

  String toJson() => json.encode(toMap());
}

@JsonSerializable(explicitToJson: true)
class InitiateRazorpayPaymentEntity {
  final String key;
  final String name;
  final String description;
  final int timeout;
  @JsonKey(name: 'booking_id')
  final String bookingId;
  final PrefillModel prefill;
  final RazorpayTheme theme;
  final int amount;
  @JsonKey(name: 'order_id')
  final String orderId;
  InitiateRazorpayPaymentEntity(
      {required this.bookingId,
      required this.key,
      required this.name,
      required this.description,
      required this.timeout,
      required this.prefill,
      required this.amount,
      required this.orderId,
      required this.theme});
  factory InitiateRazorpayPaymentEntity.fromJson(Map<String, dynamic> data) =>
      _$InitiateRazorpayPaymentEntityFromJson(data);

  Map<String, dynamic> toJson() => _$InitiateRazorpayPaymentEntityToJson(this);
}

@JsonSerializable()
class PrefillModel {
  final String contact;
  final String email;
  PrefillModel({
    required this.contact,
    required this.email,
  });

  factory PrefillModel.fromJson(Map<String, dynamic> data) =>
      _$PrefillModelFromJson(data);

  Map<String, dynamic> toJson() => _$PrefillModelToJson(this);
}

@JsonSerializable()
class RazorpayTheme {
  final String color;
  RazorpayTheme({
    required this.color,
  });

  factory RazorpayTheme.fromJson(Map<String, dynamic> data) =>
      _$RazorpayThemeFromJson(data);

  Map<String, dynamic> toJson() => _$RazorpayThemeToJson(this);
}
