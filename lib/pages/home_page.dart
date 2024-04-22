import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nibba/bloc/chat_bloc.dart';
import 'package:nibba/models/chat_message_model.dart';

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
        backgroundColor: const Color(0xFF584cd7),
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
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xff7b70ee),
                        ),
                        child: const Center(
                          child: Text(
                            "Nibba",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFfefefe),
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
                                  if (messages[index].role=="user")
                                   Expanded( child:Container()),
                                  Container(
                                      constraints: BoxConstraints(minWidth: 80, maxWidth: 300),
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(16),
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
                                      color: messages[index].role == "user" ? const Color(0xFFfefefe): const Color(0xff7b70ee)
                                      ),
                                      child:
                                          Text(
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: messages[index].role=="user"?const Color(0xFF635e8c):const Color(0xFFfefefe),
                                                fontFamily: 'dekko'),
                                            messages[index].parts.first.text
                                          )
                                      ),
                                  if (messages[index].role=="model")
                                   Expanded( child:Container()),
                                ],
                              );
                            })
                      ),
                      
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                                
                                child: TextField(
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff635e8c),
                                  ),
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      fillColor: const Color(0xFFfefefe),
                                      filled: true,
                                      border: OutlineInputBorder(
                                          
                                          borderRadius: BorderRadius.circular(50),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF7b70ee),
                                            width: 2
                                          ),
                                        ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF7b70ee),
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
                              child: const CircleAvatar(
                                radius: 32,
                                backgroundColor: Color(0xFF7b70ee),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xFFfefefe),
                                  child: Center(
                                    child: Icon(
                                      Icons.send,
                                      color: Color(0xFF584cd7),
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
                return const SizedBox();
            }
          },
        )
      );
  }
}
