import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  /*Pointer: 儲存一個來自main.dart的變數(型態為函式)
  以及answertext
  */
  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text(answerText),
        color: Colors.blue /*Button顏色 */,
        textColor: Colors.white,
        onPressed: selectHandler,
      ),
    );
  }
}
