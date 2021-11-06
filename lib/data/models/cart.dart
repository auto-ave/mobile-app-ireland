import 'package:json_annotation/json_annotation.dart';

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
  CartModel({
    this.id,
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
  });

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
            : null);
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
  CartEntity({
    this.id,
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
  });

  factory CartEntity.fromJson(Map<String, dynamic> data) =>
      _$CartEntityFromJson(data);

  Map<String, dynamic> toJson() => _$CartEntityToJson(this);
}
