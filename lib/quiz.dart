import 'package:flutter/material.dart';

import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //顯示questions map中的題目
        Question(
          questions[questionIndex]['questiontext'] as String,
        ),
        /*
        (1)顯示questions map中的回答by map() function
        (2)傳入function到answer.dart的Pointer中 
        (3)用括弧()和as List告訴dart這底下整個是個資料型態list + Object(分數)
        (4)實現類似list中的list*/
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']),
              answer['text'] as String) /*雙參數*/;
        }).toList()
        //AnswerQuestion函式不加括號(是pointer)，就不會馬上執行，而是等到點按鈕後才執行
        //Onpressed也可以不必額外寫一個function，可以直接寫Anonymous Function(單行or多行function)
      ],
    );
  }
}
