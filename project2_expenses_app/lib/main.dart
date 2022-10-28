import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      //theme:An Object，統一設計
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontFamily: 'Opensans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    titleLarge: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                )),
          )),
      home: MyHomePage(),
    );
  }
}

//要跳出新增視窗，要轉成stateful
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransations = [
    /*預設交易清單
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 2000,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 1000,
      date: DateTime.now(),
    ),*/
  ];

  //取得七天內交易數據
  List<Transaction> get _recentTransactions {
    //return 一個List
    return _userTransations.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransations.add(newTx);
    });
  }

  //點開加號icon 跳出新增交易頁面 Showing a Model Bottom Sheet
  void _startAddNewTransaction(BuildContext ctx /*context */) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTranscation(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //利用Container控制大小
        title: Text(
          'Expenses App',
          style: TextStyle(fontFamily: 'Open Sans'),
        ),
        //可以在AppBar添加一些Widgets by actions[]
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add /*加號icon */),
          )
        ],
      ),
      //在Column外包一層SingleChildScrollView 讓Column能滑動
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: 縱向排列方式
          crossAxisAlignment: CrossAxisAlignment.center /*橫向排列方式*/,
          children: <Widget>[
            Chart(_recentTransactions),
            TranscationList(_userTransations),
          ],
        ),
      ),
      //添加新項目的floatingActionButton
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      //控制floatingActionButton的位置
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
