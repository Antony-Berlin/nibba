import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nibba/models/chat_message_model.dart';
import 'package:nibba/repos/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  }

  List<ChatMessageModel> messages = [];
  FutureOr<void> chatGenerateNewTextMessageEvent(
    ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit
  ) async {

    messages.add(ChatMessageModel(role: "user", parts: [
      ChatPartModel(text: event.inputMessage)
    ]));
    messages.add(ChatMessageModel(role: "model", parts: [
      ChatPartModel(text: "typing...")
    ]));
    emit(ChatSuccessState(messages: messages));
       
    String generatedText = await ChatRepo.chatTextGeneration(messages.sublist(0, messages.length - 1));
        
    if(generatedText.isNotEmpty){
      messages.removeLast();
      messages.add(ChatMessageModel(role: 'model', parts: [ChatPartModel(text: generatedText)]));
    }
    emit(ChatSuccessState(messages: messages));
    
  }
}








