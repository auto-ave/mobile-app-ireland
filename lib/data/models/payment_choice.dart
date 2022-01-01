import 'package:json_annotation/json_annotation.dart';
part 'payment_choice.g.dart';

class PaymentChoice {
  final String type;
  final String title;
  final String description;
  final bool active;
  final num amount;
  PaymentChoice({
    required this.type,
    required this.title,
    required this.description,
    required this.active,
    required this.amount,
  });
  factory PaymentChoice.fromEntity(PaymentChoiceEntity e) {
    return PaymentChoice(
        type: e.type,
        title: e.title,
        description: e.description,
        active: e.active,
        amount: e.amount);
  }
}

@JsonSerializable()
class PaymentChoiceEntity {
  final String type;
  final String title;
  final String description;
  final bool active;
  final num amount;
  PaymentChoiceEntity({
    required this.type,
    required this.title,
    required this.description,
    required this.active,
    required this.amount,
  });

  factory PaymentChoiceEntity.fromJson(Map<String, dynamic> data) =>
      _$PaymentChoiceEntityFromJson(data);

  Map<String, dynamic> toJson() => _$PaymentChoiceEntityToJson(this);
}
