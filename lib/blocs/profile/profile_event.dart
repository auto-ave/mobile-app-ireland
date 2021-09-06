part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final UserProfileEntity userProfileEntity;
  UpdateProfile({
    required this.userProfileEntity,
  });
}
