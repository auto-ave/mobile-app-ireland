import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

class UserProfile {
  final String? firstName;
  final String? lastName;
  final String? email;
  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserProfile.fromEntity({required UserProfileEntity entity}) {
    return UserProfile(
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email);
  }

  @override
  String toString() =>
      'UserProfile(firstName: $firstName, lastName: $lastName, email: $email)';
}

@JsonSerializable()
class UserProfileEntity {
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'email')
  final String? email;
  UserProfileEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
  factory UserProfileEntity.fromJson(Map<String, dynamic> data) =>
      _$UserProfileEntityFromJson(data);

  Map<String, dynamic> toJson() => _$UserProfileEntityToJson(this);

  @override
  String toString() =>
      'UserProfileEntity(firstName: $firstName, lastName: $lastName, email: $email)';
}
