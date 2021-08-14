// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreEntity _$StoreEntityFromJson(Map<String, dynamic> json) {
  return StoreEntity(
    ratingCount: json['rating_count'] as int?,
    id: json['id'] as int?,
    name: json['name'] as String?,
    thumbnail: json['thumbnail'] as String?,
    rating: json['rating'] as String?,
    description: json['description'] as String?,
    owner: json['owner'] as int?,
    city: json['city'] as String?,
    address: json['address'] as String?,
    slug: json['slug'] as String?,
    emails:
        (json['emails'] as List<dynamic>?)?.map((e) => e as String).toList(),
    latitude: json['latitude'] as String?,
    longitude: json['longitude'] as String?,
    createdAt: json['created_at'] as String?,
    updatedAt: json['updated_at'] as String?,
    isActive: json['is_active'] as bool?,
    contactNumbers: (json['contact_numbers'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    storeRegistrationType: json['store_registration_type'] as String?,
    storeRegistrationNumber: json['registration_number'] as String?,
    contactPersonName: json['contact_person_name'] as String?,
    contactPersonNumber: json['contact_person_number'] as String?,
    contactPersonPhoto: json['contact_person_photo'] as String?,
    storeOpeningTime: json['opening_time'] as String?,
    storeClosingTime: json['closing_time'] as String?,
    supportedVehicleType: (json['supported_vehicle_type'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList(),
  );
}

Map<String, dynamic> _$StoreEntityToJson(StoreEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'rating': instance.rating,
      'description': instance.description,
      'owner': instance.owner,
      'city': instance.city,
      'address': instance.address,
      'slug': instance.slug,
      'emails': instance.emails,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_active': instance.isActive,
      'contact_numbers': instance.contactNumbers,
      'store_registration_type': instance.storeRegistrationType,
      'registration_number': instance.storeRegistrationNumber,
      'contact_person_name': instance.contactPersonName,
      'contact_person_number': instance.contactPersonNumber,
      'contact_person_photo': instance.contactPersonPhoto,
      'opening_time': instance.storeOpeningTime,
      'closing_time': instance.storeClosingTime,
      'supported_vehicle_type': instance.supportedVehicleType,
      'rating_count': instance.ratingCount,
    };
