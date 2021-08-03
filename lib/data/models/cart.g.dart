// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartEntity _$CartEntityFromJson(Map<String, dynamic> json) {
  return CartEntity(
    id: json['id'] as int?,
    createdAt: json['created_at'] as String?,
    subTotal: json['subtotal'] as String?,
    total: json['total'] as String?,
    completed: json['completed'] as bool?,
    store: json['store'] as int?,
    consumer: json['consumer'] as int?,
    items: (json['items'] as List<dynamic>?)?.map((e) => e as int).toList(),
    itemsObj: (json['item_objs'] as List<dynamic>?)
        ?.map((e) => PriceTimeListEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CartEntityToJson(CartEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'subtotal': instance.subTotal,
      'total': instance.total,
      'completed': instance.completed,
      'store': instance.store,
      'consumer': instance.consumer,
      'items': instance.items,
      'item_objs': instance.itemsObj?.map((e) => e.toJson()).toList(),
    };
