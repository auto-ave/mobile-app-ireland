import 'package:json_annotation/json_annotation.dart';

part 'razorpay_payment_response.g.dart';

class RazorpayPaymentResponse {
  final String razorpayPaymentId;
  final String razorpayOrderId;
  final String razorpaySignature;
  RazorpayPaymentResponse({
    required this.razorpayPaymentId,
    required this.razorpayOrderId,
    required this.razorpaySignature,
  });
  factory RazorpayPaymentResponse.fromEntity(
      RazorpayPaymentResponseEntity entity) {
    return RazorpayPaymentResponse(
      razorpayPaymentId: entity.razorpayPaymentId,
      razorpayOrderId: entity.razorpayOrderId,
      razorpaySignature: entity.razorpaySignature,
    );
  }
  RazorpayPaymentResponseEntity toEntity() {
    return RazorpayPaymentResponseEntity(
      razorpayPaymentId: razorpayPaymentId,
      razorpayOrderId: razorpayOrderId,
      razorpaySignature: razorpaySignature,
    );
  }

  @override
  String toString() =>
      'RazorpayPaymentResponse(razorpayPaymentId: $razorpayPaymentId, razorpayOrderId: $razorpayOrderId, razorpaySignature: $razorpaySignature)';
}

@JsonSerializable()
class RazorpayPaymentResponseEntity {
  @JsonKey(name: 'razorpay_payment_id')
  final String razorpayPaymentId;
  @JsonKey(name: 'razorpay_order_id')
  final String razorpayOrderId;
  @JsonKey(name: 'razorpay_signature')
  final String razorpaySignature;
  RazorpayPaymentResponseEntity({
    required this.razorpayPaymentId,
    required this.razorpayOrderId,
    required this.razorpaySignature,
  });
  factory RazorpayPaymentResponseEntity.fromJson(Map<String, dynamic> data) =>
      _$RazorpayPaymentResponseEntityFromJson(data);

  Map<String, dynamic> toJson() => _$RazorpayPaymentResponseEntityToJson(this);
}
