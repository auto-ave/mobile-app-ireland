import 'package:json_annotation/json_annotation.dart';

import 'package:themotorwash/data/models/payment.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/store.dart';

part 'booking_detail.g.dart';

class BookingDetailModel {
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
  final List<PriceTimeListModel>? services;
  final int? amount;
  final PaymentModel? payment;

  BookingDetailModel({
    this.id,
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
    this.services,
    this.amount,
    this.payment,
  });

  factory BookingDetailModel.fromEntity(BookingDetailEntity e) {
    return BookingDetailModel(
        amount: e.amount,
        bookedBy: e.bookedBy,
        bookingId: e.bookingId,
        createdAt: e.createdAt != null ? DateTime.parse(e.createdAt!) : null,
        updatedAt: e.updatedAt != null ? DateTime.parse(e.updatedAt!) : null,
        event: e.event,
        id: e.id,
        isRefunded: e.isRefunded,
        otp: e.otp,
        payment: e.payment != null ? PaymentModel.fromEntity(e.payment!) : null,
        services: e.services != null
            ? e.services!
                .map<PriceTimeListModel>(
                    (e) => PriceTimeListModel.fromEntity(e))
                .toList()
            : null,
        status: e.status,
        statusChangedTime: e.statusChangedTime != null
            ? DateTime.parse(e.statusChangedTime!)
            : null,
        store: e.store,
        vehicleType: e.vehicleType);
  }

  @override
  String toString() {
    return 'BookingDetailModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, bookingId: $bookingId, status: $status, statusChangedTime: $statusChangedTime, otp: $otp, event: $event, vehicleType: $vehicleType, store: $store, bookedBy: $bookedBy, isRefunded: $isRefunded, services: $services, amount: $amount, payment: $payment)';
  }
}

@JsonSerializable(explicitToJson: true)
class BookingDetailEntity {
  final int? id;
  @JsonKey(name: 'booking_id')
  final String? bookingId;
  final PaymentEntity? payment;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  final int? status;
  final int? amount;

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
  final List<PriceTimeListEntity>? services;
  BookingDetailEntity({
    this.id,
    this.bookingId,
    required this.payment,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.amount,
    this.statusChangedTime,
    this.otp,
    this.event,
    this.vehicleType,
    this.store,
    this.bookedBy,
    this.isRefunded,
    this.services,
  });

  factory BookingDetailEntity.fromJson(Map<String, dynamic> data) =>
      _$BookingDetailEntityFromJson(data);

  Map<String, dynamic> toJson() => _$BookingDetailEntityToJson(this);
}
