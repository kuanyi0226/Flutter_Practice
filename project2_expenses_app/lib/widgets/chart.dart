import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart'; //for日期格式

class Chart extends StatelessWidget {
  final List<Transaction> recentTranscations;
  //Constructor
  Chart(this.recentTranscations);

  //畫chart的七根柱子(7天花費)
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum;

      for (var i = 0; i < recentTranscations.length; i++) {
        if (recentTranscations[i].date.day == weekDay.day &&
            recentTranscations[i].date.month == weekDay.month &&
            recentTranscations[i].date.year == weekDay.year) {
          totalSum += recentTranscations[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1) /*星期幾 */,
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(children: [
        groupedTransactionValues.map((data) {
          return Text('${data['day']} : ${data['amount']}');
        }).toList(),
      ]),
    );
  }
}
