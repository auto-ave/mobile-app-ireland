import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

class BookingModel {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? bookingId;
  final int? status;
  final DateTime? statusChangedTime;
  final String? otp;
  final int? event;
  final int? vehicleType;
  final int? store;
  final int? bookedBy;
  final bool? isRefunded;
  final List<String>? serviceNames;
  final int? amount;

  BookingModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.bookingId,
      this.status,
      this.statusChangedTime,
      this.otp,
      this.event,
      this.vehicleType,
      this.serviceNames,
      this.store,
      this.bookedBy,
      this.isRefunded,
      this.amount});
  factory BookingModel.fromEntity(BookingEntity e) {
    return BookingModel(
        amount: e.amount,
        bookedBy: e.bookedBy,
        bookingId: e.bookingId,
        createdAt: DateTime.parse(e.createdAt!),
        event: e.event,
        id: e.id,
        isRefunded: e.isRefunded,
        otp: e.otp,
        serviceNames: e.serviceNames,
        status: e.status,
        statusChangedTime: DateTime.parse(e.statusChangedTime!),
        store: e.store,
        updatedAt: DateTime.parse(e.updatedAt!),
        vehicleType: e.vehicleType);
  }

  @override
  String toString() {
    return 'BookingModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, bookingId: $bookingId, status: $status, statusChangedTime: $statusChangedTime, otp: $otp, event: $event, vehicleType: $vehicleType, store: $store, bookedBy: $bookedBy, isRefunded: $isRefunded, serviceNames: $serviceNames, amount: $amount)';
  }
}

@JsonSerializable()
class BookingEntity {
  final int? id;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'booking_id')
  final String? bookingId;

  final int? status;

  @JsonKey(name: 'status_changed_time')
  final String? statusChangedTime;

  final String? otp;
  final int? event;

  @JsonKey(name: 'vehicle_type')
  final int? vehicleType;

  final int? store;
  @JsonKey(name: 'booked_by')
  final int? bookedBy;

  @JsonKey(name: 'is_refunded')
  final bool? isRefunded;

  @JsonKey(name: 'price_times')
  final List<String>? serviceNames;

  final int? amount;
  BookingEntity(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.bookingId,
      this.status,
      this.statusChangedTime,
      this.otp,
      this.event,
      this.vehicleType,
      this.store,
      this.bookedBy,
      this.isRefunded,
      this.serviceNames,
      this.amount});
  factory BookingEntity.fromJson(Map<String, dynamic> data) =>
      _$BookingEntityFromJson(data);

  Map<String, dynamic> toJson() => _$BookingEntityToJson(this);
}
