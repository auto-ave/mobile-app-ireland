// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokensEntity _$AuthTokensEntityFromJson(Map<String, dynamic> json) {
  return AuthTokensEntity(
    refreshToken: json['refresh'] as String?,
    accessToken: json['access'] as String?,
  );
}

Map<String, dynamic> _$AuthTokensEntityToJson(AuthTokensEntity instance) =>
    <String, dynamic>{
      'refresh': instance.refreshToken,
      'access': instance.accessToken,
    };
