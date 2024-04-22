import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:nibba/models/chat_message_model.dart';

import '../utils/constants.dart';

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
}