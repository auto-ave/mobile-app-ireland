import 'package:json_annotation/json_annotation.dart';
import 'package:themotorwash/data/models/booking_detail.dart';

import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/models/store.dart';

part 'booking_list_model.g.dart';

class BookingListModel {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? bookingId;
  final BookingStatus status;
  final DateTime? statusChangedTime;
  final String? otp;
  final int? event;
  final String? vehicleType;
  final Store? store;
  final int? bookedBy;
  final bool? isRefunded;
  final List<String>? serviceNames;
  final String? amount;

  BookingListModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.bookingId,
      required this.status,
      this.statusChangedTime,
      this.otp,
      this.event,
      this.vehicleType,
      this.serviceNames,
      this.store,
      this.bookedBy,
      this.isRefunded,
      this.amount});
  factory BookingListModel.fromEntity(BookingListEntity e) {
    return BookingListModel(
        amount: e.amount,
        bookedBy: e.bookedBy,
        bookingId: e.bookingId,
        createdAt: DateTime.parse(e.createdAt!),
        event: e.event,
        id: e.id,
        isRefunded: e.isRefunded,
        otp: e.otp,
        serviceNames: e.serviceNames,
        status: e.status != null
            ? getBookingStatusFromCode(e.status!)
            : BookingStatus.notDefined,
        statusChangedTime: DateTime.parse(e.statusChangedTime!),
        store: Store.fromEntity(e.store!),
        updatedAt: DateTime.parse(e.updatedAt!),
        vehicleType: e.vehicleType);
  }

  @override
  String toString() {
    return 'BookingListModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, bookingId: $bookingId, status: $status, statusChangedTime: $statusChangedTime, otp: $otp, event: $event, vehicleType: $vehicleType, store: $store, bookedBy: $bookedBy, isRefunded: $isRefunded, serviceNames: $serviceNames, amount: $amount)';
  }
}

@JsonSerializable(explicitToJson: true)
class BookingListEntity {
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
  final String? vehicleType;

  final StoreEntity? store;
  @JsonKey(name: 'booked_by')
  final int? bookedBy;

  @JsonKey(name: 'is_refunded')
  final bool? isRefunded;

  @JsonKey(name: 'price_times')
  final List<String>? serviceNames;

  final String? amount;

  final ReviewEntity? review;
  BookingListEntity(
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
      this.amount,
      this.review});
  factory BookingListEntity.fromJson(Map<String, dynamic> data) =>
      _$BookingListEntityFromJson(data);

  Map<String, dynamic> toJson() => _$BookingListEntityToJson(this);

  @override
  String toString() {
    return 'BookingListEntity(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, bookingId: $bookingId, status: $status, statusChangedTime: $statusChangedTime, otp: $otp, event: $event, vehicleType: $vehicleType, store: $store, bookedBy: $bookedBy, isRefunded: $isRefunded, serviceNames: $serviceNames, amount: $amount, review: $review)';
  }
}
