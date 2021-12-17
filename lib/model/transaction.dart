import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Transaction with ChangeNotifier {
  final String id;
  final bool attendance;
  final double price;
  final int route;
  final String address;
  DateTime date;

  Transaction(
      {required this.id,
      required this.price,
      required this.route,
      required this.address,
      required this.attendance,
      required this.date});

  // Future<void> transactionToDB(Transaction trans) async {
  //   try {
  //     final url =
  //         'https://authentication-16dfc-default-rtdb.firebaseio.com/transaction.json';
  //     final response = http.post(url,
  //         body: json.encode({
  //           'id': 123,
  //           'price': trans.price,
  //           'date': trans.date,
  //         }));

  //     final my_new_Transaction =
  //         Transaction(id: trans.id, price: 150, date: trans.date);
  //     _transaction.add(my_new_Transaction);
  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }
}
