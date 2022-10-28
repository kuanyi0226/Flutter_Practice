import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

//Normal Object( Not a Widget)
//serve as a model for data
class Transaction {
  final String id; //每個transtion都有個id
  final String title;
  final double amount; //money
  final DateTime date;

  //Constructor
  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}
