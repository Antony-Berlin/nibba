import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final String initialAnswer;
  final Function(String) onAnswerChanged;

  const QuestionWidget({
    Key? key,
    required this.question,
    required this.initialAnswer,
    required this.onAnswerChanged,
  }) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late String _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _selectedAnswer = widget.initialAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(0xFFfefefe)
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color:  Color(0xFF635e8c),
              fontFamily: 'dekko'
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedAnswer = "Yes";
                    widget.onAnswerChanged("Yes");
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: _selectedAnswer == "Yes" ? Colors.green : null,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:  _selectedAnswer == "Yes" ? Colors.white:Color(0xFF635e8c),
                    fontFamily: 'dekko'
                  )
                ),
                child: const Text(
                  'Yes',
                ),
                
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedAnswer = "No";
                    widget.onAnswerChanged("No");
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: _selectedAnswer == "No" ? Colors.red : null,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:  _selectedAnswer == " " ? Color(0xFF635e8c):Colors.white,
                    fontFamily: 'dekko'
                  )
                ),
                child: const Text(
                  
                  'No'
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
