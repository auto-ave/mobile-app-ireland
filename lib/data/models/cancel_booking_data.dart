import 'package:json_annotation/json_annotation.dart';

part 'cancel_booking_data.g.dart';

class CancelBookingData {
  final List<String> reasons;
  final num refundAmount;
  final bool isRefundable;
  CancelBookingData({
    required this.reasons,
    required this.refundAmount,
    required this.isRefundable,
  });

  factory CancelBookingData.fromEntity(CancelBookingDataEntity e) {
    return CancelBookingData(
        reasons: e.reasons,
        refundAmount: e.refundAmount,
        isRefundable: e.isRefundable);
  }
}

@JsonSerializable()
class CancelBookingDataEntity {
  final List<String> reasons;
  @JsonKey(name: 'refund_amount')
  final num refundAmount;
  @JsonKey(name: 'is_refundable')
  final bool isRefundable;
  CancelBookingDataEntity({
    required this.reasons,
    required this.refundAmount,
    required this.isRefundable,
  });
  factory CancelBookingDataEntity.fromJson(Map<String, dynamic> data) =>
      _$CancelBookingDataEntityFromJson(data);

  Map<String, dynamic> toJson() => _$CancelBookingDataEntityToJson(this);
}
