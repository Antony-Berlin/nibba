part of 'answer_bloc.dart';

@immutable
sealed class AnswerEvent {}

class AnswerChangeEvent extends AnswerEvent {
  final String value;
  final int index;
  AnswerChangeEvent({
    required this.value,
    required this.index
  });
}
class AnswerCreateEvent extends AnswerEvent {
  final int len;
  AnswerCreateEvent({
    required this.len,
  });
  
}
