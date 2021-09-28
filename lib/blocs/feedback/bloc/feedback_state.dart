part of 'feedback_bloc.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class FeedbackSent extends FeedbackState {}

class FeedbackError extends FeedbackState {
  final String message;
  FeedbackError({
    required this.message,
  });
}

class FeedbackLoading extends FeedbackState {}
