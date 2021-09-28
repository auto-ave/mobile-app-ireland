part of 'feedback_bloc.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class SendFeedback extends FeedbackEvent {
  final String email;
  final String phone;
  final String message;
  SendFeedback({
    required this.email,
    required this.phone,
    required this.message,
  });
  @override
  List<Object> get props => [];
}
