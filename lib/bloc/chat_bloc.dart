import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nibba/models/chat_message_model.dart';
import 'package:nibba/models/elies_model.dart';
import 'package:nibba/repos/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
    on<EligibiltyCheckEvent>(eligibiltyCheckEvent);
    on<EligibilityResultEvent>(eligibilityResultEvent);
  }
  // ChatBloc() : super(EligibiltyCheckState(elies: [])) {
  //   on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  // }

  List<ChatMessageModel> messages = [];
  List<EliesModel> elies = [];
  
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



  FutureOr<void> eligibiltyCheckEvent(
    EligibiltyCheckEvent event, Emitter<ChatState> emit
  )async{
    int index = event.index;
    messages.removeRange(index+1, messages.length);
    messages.add(ChatMessageModel(role: 'user', parts: [
      ChatPartModel(text: "Check Eligibility")
    ]));
    
    messages.add(ChatMessageModel(role: 'model', parts: [
      ChatPartModel(text: "Creating your assesment...   :)")
    ]));
    emit(ChatSuccessState(messages: messages));
    elies = [];
    String temp = await ChatRepo.geElies(messages);
    List<dynamic> jsonArray = json.decode(temp);
    for (var jsonObject in jsonArray) {
      EliesModel model = EliesModel.fromJson(jsonObject);
      elies.add(model);
    }
    emit(EligibiltyCheckState(elies:  elies));
    elies = [];
  }

  FutureOr<void> eligibilityResultEvent(EligibilityResultEvent event, Emitter<ChatState> emit) {
    messages.removeLast();
    messages.add(ChatMessageModel(role: 'model', parts: [
      ChatPartModel(text: event.result)
    ]));
    emit(ChatSuccessState(messages: messages));
  }
}








