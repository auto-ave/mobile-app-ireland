// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileEntity _$UserProfileEntityFromJson(Map<String, dynamic> json) {
  return UserProfileEntity(
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    email: json['email'] as String?,
  );
}

Map<String, dynamic> _$UserProfileEntityToJson(UserProfileEntity instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
    };
