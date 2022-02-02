import 'package:json_annotation/json_annotation.dart';

import 'package:themotorwash/data/models/offer.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/vehicle_model.dart';
import 'package:themotorwash/data/models/vehicle_type.dart';

part 'cart.g.dart';

class CartModel {
  final int? id;
  final DateTime? createdAt;
  final String? subTotal;
  final String? total;
  final bool? completed;
  final Store? store;
  final int? consumer;
  final List<int>? items;
  final List<PriceTimeListModel>? itemsObj;
  final VehicleModel? vehicleModel;
  final VehicleTypeModel? vehicleType;
  final OfferModel? offer;
  final String? discount;
  final bool? isMultiDay;

  CartModel(
      {this.id,
      this.createdAt,
      this.subTotal,
      this.total,
      this.completed,
      this.store,
      this.consumer,
      this.items,
      this.itemsObj,
      this.vehicleModel,
      this.vehicleType,
      this.discount,
      this.offer,
      required this.isMultiDay});

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
        id: entity.id!,
        createdAt: DateTime.parse(entity.createdAt!),
        subTotal: entity.subTotal,
        total: entity.total,
        completed: entity.completed,
        store: entity.store != null ? Store.fromEntity(entity.store!) : null,
        consumer: entity.consumer,
        items: entity.items,
        itemsObj: entity.itemsObj!
            .map((e) => PriceTimeListModel.fromEntity(e))
            .toList(),
        vehicleModel: entity.vehicleModel != null
            ? VehicleModel.fromEntity(entity.vehicleModel!)
            : null,
        vehicleType: entity.vehicleType != null
            ? VehicleTypeModel.fromEntity(entity.vehicleType!)
            : null,
        offer:
            entity.offer != null ? OfferModel.fromEntity(entity.offer!) : null,
        discount: entity.discount,
        isMultiDay: entity.isMultiDay);
  }

  @override
  String toString() {
    return 'CartModel(id: $id, createdAt: $createdAt, subTotal: $subTotal, total: $total, completed: $completed, store: $store, consumer: $consumer, items: $items, itemsObj: $itemsObj, vehicleModel: $vehicleModel, vehicleType: $vehicleType, offer: $offer)';
  }
}

@JsonSerializable(explicitToJson: true)
class CartEntity {
  final int? id;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'subtotal')
  final String? subTotal;
  final String? total;
  final bool? completed;
  final StoreEntity? store;
  final int? consumer;
  final List<int>? items;
  @JsonKey(name: 'vehicle_model')
  final VehicleModelEntity? vehicleModel;
  @JsonKey(name: 'item_objs')
  final List<PriceTimeListEntity>? itemsObj;
  @JsonKey(name: 'vehicle_type')
  final VehicleTypeEntity? vehicleType;
  @JsonKey(name: 'is_multi_day')
  final bool? isMultiDay;

  final String? discount;
  final OfferEntity? offer;
  CartEntity(
      {this.id,
      this.createdAt,
      this.subTotal,
      this.total,
      this.completed,
      this.store,
      this.consumer,
      this.items,
      this.itemsObj,
      this.vehicleModel,
      this.vehicleType,
      this.discount,
      this.offer,
      required this.isMultiDay});

  factory CartEntity.fromJson(Map<String, dynamic> data) =>
      _$CartEntityFromJson(data);

  Map<String, dynamic> toJson() => _$CartEntityToJson(this);
}
