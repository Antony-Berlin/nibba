import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nibba/bloc/chat_bloc.dart';
import 'package:nibba/models/chat_message_model.dart';
import 'package:nibba/models/elies_model.dart';
import 'package:nibba/pages/questionWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  List<String> answers = [];
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
                        child: Row(
                          children: [
                            Expanded(
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
                            GestureDetector(
                              onTap: (){
                                print("opening dialer");
                                _makePhoneCall('1100'); 
                              },
                              child: Container(
                                margin: EdgeInsets.all(30),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFFfefefe),
                                ),
                                child: Icon(
                                  Icons.call,
                                  color:  Color(0xFF584cd7),
                                ),
                              ),
                              
                            )
                            
                          ],
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
                                      child:Column(
                                        children: [
                                          Text(
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: messages[index].role=="user"?const Color(0xFF635e8c):const Color(0xFFfefefe),
                                                fontFamily: 'dekko'),
                                            messages[index].parts.first.text
                                          ),
                                          messages[index].role=='model'&&
                                            (messages[index].parts.first.text.toLowerCase().contains("eligible")
                                            ||messages[index].parts.first.text.toLowerCase().contains("eligibility"))
                                            &&!(messages[index].parts.first.text.toLowerCase().contains("yes you are eligible")
                                            ||messages[index].parts.first.text.toLowerCase().contains("you are not eligible" )
                                            )
                                            ?
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            child:ElevatedButton(
                                            onPressed: () {
                                              chatBloc.add(EligibiltyCheckEvent(index:index));
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(MaterialState.disabled)) {
                                                    return Colors.grey; // Gray when disabled
                                                  }
                                                  return const Color(0xFFfefefe);
                                                },
                                              ),
                                            ),
                                            child: const Text(
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(0xFF635e8c),
                                                    fontFamily: 'dekko'),
                                                "Check Eligibilty"
                                            ),
                                            
                                          )
                                          ): SizedBox()
                                        ],
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
              case EligibiltyCheckState:
                List<EliesModel> elies = (state as EligibiltyCheckState).elies; 
                
                answers = List<String>.filled(elies.length, " ");
                // answers[2] = "No";

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
                            "Check Eligibility",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFfefefe),
                                fontSize: 35,
                                fontFamily: 'dekko'),
                          ),
                        ),
                      ),
                      Expanded(
                        child:  Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: elies.length,
                                  itemBuilder: (context, index) {
                                    
                                    return QuestionWidget(
                                      question: elies[index].question,
                                      initialAnswer: answers[index],
                                      onAnswerChanged: (String newAnswer) {
                                        // setState(() {
                                          answers[index] = newAnswer;
                                        // });
                                      }
                                    );
                                  },
                                ),
                              ),
                              ElevatedButton(
                                
                                onPressed: () {
                                  // Check eligibility
                                  bool eligible = true; 
                                  bool answeredAll = true; // Assume initially eligible
                                  for (int i = 0; i < elies.length; i++) {
                                    if(answers[i] == " "){
                                      answeredAll = false;
                                      break;
                                    }
                                    if (answers[i] != elies[i].answer) {
                                      eligible = false;
                                      break;
                                    }
                                  }
                                    // Show Snackbar based on eligibility
                                  if(!answeredAll){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text("please answer all the questions"),
                                      ));
                                  }else{
                                    answers = [];
                                    chatBloc.add(EligibilityResultEvent(result: eligible ? "yes you are eligible":"you are not eligible"));
                                  }
                                  
                                  
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    style:  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color:  const Color(0xFFfefefe),
                                    fontFamily: 'dekko'
                                  ),
                                    'Submit'
                                    ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.grey; // Gray when disabled
                                      }
                                      return Color(0xff7b70ee);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,)
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                );
              default:
                return const SizedBox();
            }
          },
        )
      );
  }
}


Future<void> _makePhoneCall(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}