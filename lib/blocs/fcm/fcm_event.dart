part of 'fcm_bloc.dart';

abstract class FcmEvent extends Equatable {
  const FcmEvent();
}

class RegisterTopics extends FcmEvent {
  final List<String> topics;
  RegisterTopics({
    required this.topics,
  });

  @override
  List<Object> get props => [];
}

class UpdateDeviceToken extends FcmEvent {
  @override
  List<Object> get props => [];
}

class SubscribeToTopicsNewLogin extends FcmEvent {
  @override
  List<Object> get props => [];
}
