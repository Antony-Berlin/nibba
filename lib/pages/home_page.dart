import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nibba/bloc/chat_bloc.dart';
import 'package:nibba/models/chat_message_model.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ChatBloc, ChatState>(
          bloc: chatBloc,
          listener: (context, state) {
            if (state is ChatSuccessState) {
              // After the list rebuilds, scroll to the bottom
              WidgetsBinding.instance.addPostFrameCallback((_) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              });
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case ChatSuccessState:
              List<ChatMessageModel> messages = (state as ChatSuccessState).messages; 
                return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        child: Center(
                          child: Text(
                            "Nibba",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade400,
                                fontSize: 35,
                                fontFamily: 'dekko'),
                          ),
                        ),
                      ),
                      Expanded(
                        child:
                            ListView.builder(
                            controller: scrollController,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  SizedBox(width: messages[index].role=="user"? 30:0,),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                      borderRadius: messages[index].role=="user"
                                                    ? const BorderRadius.only(topLeft: Radius.circular(16),
                                                            topRight: Radius.zero,
                                                            bottomLeft: Radius.circular(16),
                                                            bottomRight: Radius.circular(16)
                                                            )
                                                    :const BorderRadius.only(topLeft: Radius.zero,
                                                            topRight: Radius.circular(16),
                                                            bottomLeft: Radius.circular(16),
                                                            bottomRight: Radius.circular(16)
                                                            ),
                                      color: messages[index].role == "user" ? Colors.deepPurple.shade100: Colors.deepPurple.shade400
                                      ),
                                      child:
                                          Text(
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: messages[index].role=="user"?Colors.deepPurple:const Color.fromRGBO(237, 231, 246, 1),
                                                fontFamily: 'dekko'),
                                            messages[index].parts.first.text
                                          )
                                      ),
                                  ),
                                  
                                  SizedBox(width: messages[index].role=="user"? 0:30,),
                                ],
                              );
                            })
                      ),
                      
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                                
                                child: TextField(
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      fillColor: Color.fromARGB(255, 202, 197, 210),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                            color: Theme.of(context).primaryColor,
                                          )
                                        )
                                    ),
                                  )
                              ),
                            const SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              onTap: (){
                                if (textEditingController.text.isNotEmpty){
                                  String text = textEditingController.text;
                                  textEditingController.clear();
                                  chatBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
                                }
                              },
                              child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.deepPurple.shade400,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.deepPurple.shade400,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                );
                
              default:
                return SizedBox();
            }
          },
        )
      );
  }
}
