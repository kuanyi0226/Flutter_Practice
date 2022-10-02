import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resetHandler);

  //create a Getter
  String get resultPhrase {
    var resultText;
    if (resultScore <= 8) {
      resultText = 'You did well!';
    } else if (resultScore <= 12) {
      resultText = 'Pretty good';
    } else if (resultScore <= 18) {
      resultText = 'Wow fabulous';
    } else {
      resultText = 'You are the best!';
    }
    return resultText;
  }

//widgets below other widgets--->column
//顯示quiz結果 & 重新測驗按鍵
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: resetHandler,
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.blue)),
            child: Text('Restart the quiz'),
          )
        ],
      ),
    );
  }
}
