// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleTypeModelAdapter extends TypeAdapter<VehicleTypeModel> {
  @override
  final int typeId = 1;

  @override
  VehicleTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleTypeModel(
      model: fields[0] as String,
      wheel: fields[1] as String,
      description: fields[2] as String?,
      image: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleTypeModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.model)
      ..writeByte(1)
      ..write(obj.wheel)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleTypeEntity _$VehicleTypeEntityFromJson(Map<String, dynamic> json) {
  return VehicleTypeEntity(
    model: json['model'] as String,
    wheel: json['wheel'] as String,
    description: json['description'] as String?,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$VehicleTypeEntityToJson(VehicleTypeEntity instance) =>
    <String, dynamic>{
      'model': instance.model,
      'wheel': instance.wheel,
      'description': instance.description,
      'image': instance.image,
    };
