import 'package:flutter/material.dart'; //provide base class to build widgets

import 'answer.dart';
import 'quiz.dart';
import 'result.dart';

//設計問答App

void main() {
  runApp(MyApp());
}

//inherit(inside the class: variables are called properties; functions are called methods)
//MyApp 這個Stateful Widget能持續更新，MyAppState是它的初始態
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

//連接到MyApp
class MyAppState extends State<MyApp> {
  var _questionindex = 0; //控制目前頁面顯示的問題
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionindex = 0;
      _totalScore = 0;
    });
  }

  void AnswerQuestion(int score) {
    _totalScore += score;

    //告訴flutter我要更新state了，強制re-render
    setState(() {
      _questionindex += 1; //答完一題就更新下一題的題目
    });

    if (_questionindex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  //建立問題及選項的list by資料結構Map
  //const後面datatype(var,int...)可以省略
  //依照不同選項給分
  final _questions = const [
    {
      'questiontext': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questiontext': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Dog', 'score': 5},
        {'text': 'Cat', 'score': 3},
        {'text': 'Fish', 'score': 1}
      ],
    },
    {
      'questiontext': 'Who\'s your favorite idol?',
      'answers': [
        {'text': 'Miyuki', 'score': 10},
        {'text': 'Adele', 'score': 5},
        {'text': 'Taylor', 'score': 3},
        {'text': 'Justin', 'score': 1},
      ],
    }
  ];

  @override //return type: Widget
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My first app'),
        ),
        //若運行完所有題目，就不再產生問題
        body: _questionindex < _questions.length
            ? Quiz(
                answerQuestion: AnswerQuestion,
                questionIndex: _questionindex,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
    //MaterialApp() is an object; scaffold helps you build basic page
  }

  //Conneting Functoins & Buttons

}
