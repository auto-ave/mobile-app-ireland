// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleModelAdapter extends TypeAdapter<VehicleModel> {
  @override
  final int typeId = 2;

  @override
  VehicleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleModel(
      model: fields[0] as String?,
      vehicleType: fields[1] as String?,
      description: fields[2] as String?,
      image: fields[3] as String?,
      brand: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.model)
      ..writeByte(1)
      ..write(obj.vehicleType)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.brand);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleModelEntity _$VehicleModelEntityFromJson(Map<String, dynamic> json) {
  return VehicleModelEntity(
    model: json['model'] as String?,
    vehicleType: json['vehicle_type'] as String?,
    brand: json['brand'] as String?,
    description: json['description'] as String?,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$VehicleModelEntityToJson(VehicleModelEntity instance) =>
    <String, dynamic>{
      'model': instance.model,
      'vehicle_type': instance.vehicleType,
      'brand': instance.brand,
      'description': instance.description,
      'image': instance.image,
    };
