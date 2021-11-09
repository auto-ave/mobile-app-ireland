import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:themotorwash/utils/utils.dart';

part 'store.g.dart';

class Store {
  final int? id;
  final String? name;
  final String? thumbnail;
  final double? rating;
  final String? description;
  final int? owner;
  final String? city;
  final String? address;
  final String? slug;
  final List<String>? emails;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;

  final DateTime? updatedAt;

  final bool? isActive;

  final List<String>? contactNumbers;

  final String? storeRegistrationType;

  final String? storeRegistrationNumber;

  final String? contactPersonName;

  final String? contactPersonNumber;

  final String? contactPersonPhoto;

  final TimeOfDay? storeOpeningTime;

  final TimeOfDay? storeClosingTime;

  final int? ratingCount;

  final List<int>? supportedVehicleType;
  final List<String>? images;
  final int? servicesStart;

  Store(
      {required this.id,
      required this.name,
      this.thumbnail,
      this.rating,
      required this.description,
      required this.owner,
      required this.city,
      required this.address,
      this.slug,
      required this.emails,
      required this.latitude,
      required this.longitude,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      required this.contactNumbers,
      required this.storeRegistrationType,
      required this.storeRegistrationNumber,
      required this.contactPersonName,
      required this.contactPersonNumber,
      this.contactPersonPhoto,
      required this.storeOpeningTime,
      required this.storeClosingTime,
      this.supportedVehicleType,
      this.ratingCount,
      this.images,
      this.servicesStart});

  factory Store.fromEntity(StoreEntity entity) {
    return Store(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        owner: entity.owner,
        city: entity.city,
        address: entity.address,
        emails: entity.emails,
        latitude:
            entity.latitude != null ? double.parse(entity.latitude!) : null,
        longitude:
            entity.longitude != null ? double.parse(entity.longitude!) : null,
        contactNumbers: entity.contactNumbers,
        storeRegistrationType: entity.storeRegistrationType,
        storeRegistrationNumber: entity.storeRegistrationNumber,
        contactPersonName: entity.contactPersonName,
        contactPersonNumber: entity.contactPersonNumber,
        storeOpeningTime: entity.storeOpeningTime != null
            ? getTimeOfDayFromString(entity.storeOpeningTime!)
            : null,
        storeClosingTime: entity.storeClosingTime != null
            ? getTimeOfDayFromString(entity.storeClosingTime!)
            : null,
        contactPersonPhoto: entity.contactPersonPhoto,
        createdAt:
            entity.createdAt != null ? DateTime.parse(entity.createdAt!) : null,
        isActive: entity.isActive,
        rating: entity.rating != null ? double.parse(entity.rating!) : null,
        slug: entity.slug,
        supportedVehicleType: entity.supportedVehicleType,
        thumbnail: entity.thumbnail,
        updatedAt:
            entity.updatedAt != null ? DateTime.parse(entity.updatedAt!) : null,
        ratingCount: entity.ratingCount,
        images: entity.images,
        servicesStart: entity.servicesStart);
  }

  @override
  String toString() {
    return 'Store(id: $id, name: $name, thumbnail: $thumbnail, rating: $rating, description: $description, owner: $owner, city: $city, address: $address, slug: $slug, emails: $emails, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, contactNumbers: $contactNumbers, storeRegistrationType: $storeRegistrationType, storeRegistrationNumber: $storeRegistrationNumber, contactPersonName: $contactPersonName, contactPersonNumber: $contactPersonNumber, contactPersonPhoto: $contactPersonPhoto, storeOpeningTime: $storeOpeningTime, storeClosingTime: $storeClosingTime, ratingCount: $ratingCount, supportedVehicleType: $supportedVehicleType, images: $images, servicesStart: $servicesStart)';
  }
}

@JsonSerializable()
class StoreEntity {
  final int? id;
  final String? name;
  final String? thumbnail;
  final String? rating;
  final String? description;
  final int? owner;
  final String? city;
  final String? address;
  final String? slug;
  final List<String>? emails;
  final String? latitude;
  final String? longitude;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'contact_numbers')
  final List<String>? contactNumbers;

  @JsonKey(name: 'store_registration_type')
  final String? storeRegistrationType;

  @JsonKey(name: 'registration_number')
  final String? storeRegistrationNumber;

  @JsonKey(name: 'contact_person_name')
  final String? contactPersonName;

  @JsonKey(name: 'contact_person_number')
  final String? contactPersonNumber;

  @JsonKey(name: 'contact_person_photo')
  final String? contactPersonPhoto;

  @JsonKey(name: 'opening_time')
  final String? storeOpeningTime;

  @JsonKey(name: 'closing_time')
  final String? storeClosingTime;

  @JsonKey(name: 'supported_vehicle_type')
  final List<int>? supportedVehicleType;

  @JsonKey(name: 'rating_count')
  final int? ratingCount;

  final List<String>? images;
  @JsonKey(name: 'services_start')
  final int? servicesStart;

  StoreEntity(
      {required this.ratingCount,
      required this.id,
      required this.name,
      this.thumbnail,
      this.rating,
      required this.description,
      required this.owner,
      required this.city,
      required this.address,
      this.slug,
      required this.emails,
      required this.latitude,
      required this.longitude,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      required this.contactNumbers,
      required this.storeRegistrationType,
      required this.storeRegistrationNumber,
      required this.contactPersonName,
      required this.contactPersonNumber,
      this.contactPersonPhoto,
      required this.storeOpeningTime,
      required this.storeClosingTime,
      this.supportedVehicleType,
      this.images,
      this.servicesStart});

  factory StoreEntity.fromJson(Map<String, dynamic> data) =>
      _$StoreEntityFromJson(data);

  Map<String, dynamic> toJson() => _$StoreEntityToJson(this);
}
