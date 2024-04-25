part of 'answer_bloc.dart';

@immutable
sealed class AnswerState {}

final class AnswerInitial extends AnswerState {}

class AnswerChangeState extends AnswerState{
  final List<String> answers;

  AnswerChangeState({required this.answers});
}
