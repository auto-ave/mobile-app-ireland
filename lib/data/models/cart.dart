import 'package:json_annotation/json_annotation.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';

part 'cart.g.dart';

class CartModel {
  final int? id;
  final DateTime? createdAt;
  final String? subTotal;
  final String? total;
  final bool? completed;
  final int? store;
  final int? consumer;
  final List<int>? items;
  final List<PriceTimeListModel>? itemsObj;

  CartModel(
      {this.id,
      this.createdAt,
      this.subTotal,
      this.total,
      this.completed,
      this.store,
      this.consumer,
      this.items,
      this.itemsObj});

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
        id: entity.id!,
        createdAt: DateTime.parse(entity.createdAt!),
        subTotal: entity.subTotal,
        total: entity.total,
        completed: entity.completed,
        store: entity.store,
        consumer: entity.consumer,
        items: entity.items,
        itemsObj: entity.itemsObj!
            .map((e) => PriceTimeListModel.fromEntity(e))
            .toList());
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
  final int? store;
  final int? consumer;
  final List<int>? items;
  @JsonKey(name: 'item_objs')
  final List<PriceTimeListEntity>? itemsObj;
  CartEntity(
      {this.id,
      this.createdAt,
      this.subTotal,
      this.total,
      this.completed,
      this.store,
      this.consumer,
      this.items,
      this.itemsObj});
  factory CartEntity.fromJson(Map<String, dynamic> data) =>
      _$CartEntityFromJson(data);

  Map<String, dynamic> toJson() => _$CartEntityToJson(this);
}
