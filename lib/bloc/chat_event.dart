part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatGenerateNewTextMessageEvent extends ChatEvent {
  final String inputMessage;
  ChatGenerateNewTextMessageEvent({
    required this.inputMessage,
  });
}

class EligibiltyCheckEvent extends ChatEvent {
  final int index;
  EligibiltyCheckEvent({
    required this.index,
  });
  
}

class EligibilityResultEvent extends ChatEvent {
  final String result;
  EligibilityResultEvent({
    required this.result,
  });
  
}
