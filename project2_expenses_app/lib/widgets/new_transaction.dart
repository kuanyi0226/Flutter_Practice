import 'package:flutter/material.dart';

//負責新增條目的文字輸入widget
//改成stateful 讓title, amount能順利輸入並儲存(不會被clear)
class NewTranscation extends StatefulWidget {
  final Function addTx;

  NewTranscation(this.addTx);

  @override
  State<NewTranscation> createState() => _NewTranscationState();
}

class _NewTranscationState extends State<NewTranscation> {
  //使用TextEditingController()這個class存輸入的文字
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enterAmount <= 0) {
      return;
      //不會執行addTX
    }

    widget.addTx(
      //titleController.text,
      //double.parse(amountController.text),
      enteredTitle,
      enterAmount,
    );

    //Use pop()method: 輸入完按鍵盤上的勾，就自動關閉跳出的視窗
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //輸入文字區
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end /*向右對齊 */,
            children: [
              //一、輸入title
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                /*輸入的東西存到titleInput(亦可用onchanged)
                      onChanged: (val) => titleInput = val,
                      */
                onSubmitted: (_) => submitData(),
              ),
              //二、輸入金額
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                //onChanged: (val) => amountInput = val,
                keyboardType: TextInputType.number /*限定輸入的東西 */,
                //Submitted Listener: 輸入完字後，自動添加到列表，不用點Add
                onSubmitted: (_) => submitData(),
              ),
              FlatButton(
                child: Text('Add Transaction'),
                textColor: Colors.purple,
                onPressed: submitData,
              )
            ]),
      ),
    );
  }
}
