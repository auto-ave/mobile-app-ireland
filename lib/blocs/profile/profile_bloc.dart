import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/user_profile.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Repository _repository;

  ProfileBloc({required Repository repository})
      : _repository = repository,
        super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is GetProfile) {
      yield* _mapGetProfileToState();
    } else if (event is UpdateProfile) {
      yield* _mapUpdateProfileToState(entity: event.userProfileEntity);
    }
  }

  Stream<ProfileState> _mapGetProfileToState() async* {
    try {
      yield LoadingProfile();
      UserProfile userProfile = await _repository.getAccountDetails();
      yield ProfileLoaded(userProfile: userProfile);
    } catch (e) {
      yield FailedToLoadProfile(message: e.toString());
    }
  }

  Stream<ProfileState> _mapUpdateProfileToState(
      {required UserProfileEntity entity}) async* {
    try {
      yield UpdatingProfile();
      UserProfile userProfile =
          await _repository.updateAccountDetails(userProfileEntity: entity);
      yield ProfileUpdated(userProfile: userProfile);
    } catch (e) {
      yield FailedToLoadProfile(message: e.toString());
    }
  }
}
