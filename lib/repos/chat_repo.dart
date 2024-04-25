import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nibba/models/chat_message_model.dart';
import 'package:nibba/models/elies_model.dart';


class ChatRepo{
  


  static Future<String> chatTextGeneration(
    List<ChatMessageModel> previousMessages
  ) async {
    Dio dio = Dio();
    
    try{
      print( previousMessages.map((e) => e.toMap()).toList() );
      final response = await dio.post("http://127.0.0.1:8000/chat/",
        data: {
          "contents": previousMessages.map((e) => e.toMap()).toList() 

        }
      );
      if(response.statusCode !>=200 && response.statusCode!<300){
        return response.data['response'];
      }
      return "";
    }catch(e){
      log(e.toString());
      return "";
    }
  }

  static Future<String> geElies(
    List<ChatMessageModel> previousMessages
  ) async {
    Dio dio = Dio();
    
    try{
      List<ChatMessageModel> message = previousMessages.sublist(0,previousMessages.length-1);
      
      final response = await dio.post("http://127.0.0.1:8000/chat/",
        data: {
          "contents": message.map((e) => e.toMap()).toList() 

        }
      );
      if(response.statusCode !>=200 && response.statusCode!<300){
        return response.data['response'];
      }
      return "";
    }catch(e){
      log(e.toString());
      return "";
    }
  }
}