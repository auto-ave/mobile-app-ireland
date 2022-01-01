// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentChoiceEntity _$PaymentChoiceEntityFromJson(Map<String, dynamic> json) {
  return PaymentChoiceEntity(
    type: json['type'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    active: json['active'] as bool,
    amount: json['amount'] as num,
  );
}

Map<String, dynamic> _$PaymentChoiceEntityToJson(
        PaymentChoiceEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'active': instance.active,
      'amount': instance.amount,
    };
