import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //引入下載的外部package，更換時間顯示格式(原本的不易閱讀)

import '../models/transaction.dart' /*兩個..往回一個資料夾 */;

//負責畫出transaction list的widget
class TranscationList extends StatelessWidget {
  final List<Transaction> transcations;

  //Constructor
  TranscationList(this.transcations);

  @override
  Widget build(BuildContext context) {
    //把transations列表 用map()轉換成Card(tx為縮寫)
    return Container(
      //要注意設定大小
      height: 300,
      //ListView:垂直可滑動widget，有兩種使用方式:
      //(1)ListView(children:...) render所有包住的Column
      //(2)ListView.builder() 只render顯示的部分(省記憶體)
      child: transcations.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                //Waiting picture
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/102.jpg',
                    fit: BoxFit.cover /*避免圖片超出界線 */,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                //return a Card Widget
                return Card(
                  child: Row(
                    children: <Widget>[
                      //顯示出花費金額
                      Container(
                        //裝飾1:讓Container附近騰出一點空間
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        //裝飾2:畫框線，不是所有widget都有decoration(Container有)
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        //裝飾3:填充空間
                        padding: EdgeInsets.all(10),
                        child: Text(
                          /*不使用toString顯示金額 by String Interpolation
                    但可用toStringAsFixed限制小數點位數*/
                          '\$ ${transcations[index].amount.toStringAsFixed(2)}',
                          //文字裝飾:粗體、大小
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      //顯示title, date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start /*置左 */,
                        children: [
                          Text(
                            transcations[index].title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            //使用外部intl package的時間格式(DateFormat())來客製化格式(也可以不加格式參數)，也可用它無數的Constructor
                            DateFormat.yMMMd().format(transcations[index].date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              //要幾個item
              itemCount: transcations.length,
            ),
    );
  }
}
