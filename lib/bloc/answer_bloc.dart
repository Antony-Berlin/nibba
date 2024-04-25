import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  AnswerBloc() : super(AnswerChangeState(answers:  [])) {
    on<AnswerChangeEvent>(answerChangeEvent);
    on<AnswerCreateEvent>(answerCreateEvent);
  }

  List<String> answers = [];
  FutureOr<void> answerChangeEvent(
    AnswerChangeEvent event, Emitter<AnswerState> emit
  ) async {
    answers[event.index] = event.value;
    emit(AnswerChangeState(answers:answers));
  }


  FutureOr<void> answerCreateEvent(
    AnswerCreateEvent event, Emitter<AnswerState> emit
  ) async {
    answers = List<String>.filled(event.len, " ",growable: true);
    emit(AnswerChangeState(answers:answers));
  }


}
