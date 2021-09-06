part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {
  UserProfile userProfile;
  ProfileLoaded({
    required this.userProfile,
  });
  @override
  List<Object> get props => [userProfile];
}

class ProfileUpdated extends ProfileState {
  final UserProfile userProfile;
  ProfileUpdated({
    required this.userProfile,
  });
  @override
  List<Object> get props => [userProfile];
}

class LoadingProfile extends ProfileState {
  @override
  List<Object> get props => [];
}

class UpdatingProfile extends ProfileState {
  @override
  List<Object> get props => [];
}

class FailedToLoadProfile extends ProfileState {
  final String message;
  FailedToLoadProfile({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class FailedToUpdateProfile extends ProfileState {
  final String message;
  FailedToUpdateProfile({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
