import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  String questiontext;

  //Pointer
  Question(this.questiontext);

  @override
  Widget build(BuildContext context) {
    return Container(
      /*Container 是一個Widget，可以包住一些設定*/
      width: double.infinity /*能佔多寬就多寬(整個螢幕) */,
      margin: EdgeInsets.all(10) /*四周圍出10單位的空間 */,
      child: Text(
        questiontext,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
