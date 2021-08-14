import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'auth_tokens.g.dart';

class AuthTokensModel {
  final String? refreshToken;
  final String? accessToken;
  final bool authenticated;
  AuthTokensModel({
    required this.refreshToken,
    required this.accessToken,
    required this.authenticated,
  });

  factory AuthTokensModel.fromEntity(AuthTokensEntity e) {
    return AuthTokensModel(
        refreshToken: e.refreshToken,
        accessToken: e.accessToken,
        authenticated:
            (e.accessToken == "" || e.refreshToken == "") ? false : true);
  }
}

@JsonSerializable()
class AuthTokensEntity {
  @JsonKey(name: 'refresh')
  final String? refreshToken;

  @JsonKey(name: 'access')
  final String? accessToken;

  AuthTokensEntity({required this.refreshToken, required this.accessToken});

  factory AuthTokensEntity.fromJson(Map<String, dynamic> data) =>
      _$AuthTokensEntityFromJson(data);

  Map<String, dynamic> toJson() => _$AuthTokensEntityToJson(this);
}
