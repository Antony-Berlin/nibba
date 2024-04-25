part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatSuccessState extends ChatState{
  final List<ChatMessageModel> messages;

  ChatSuccessState({required this.messages});
}

class EligibiltyCheckState extends ChatState{
  final List<EliesModel> elies;

  EligibiltyCheckState({required this.elies});
}