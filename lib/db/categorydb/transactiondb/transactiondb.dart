import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/model/category/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> deleteitem(int key);
  Future<void> edittransaction(TransactionModel value);
  Future<void> reset();
  Future<void> checkNotification();
}

class Transactiondb implements TransactionFunctions {
  Transactiondb._internal();
  static Transactiondb instance = Transactiondb._internal();
  factory Transactiondb() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionlistnotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    var key = await db.add(obj);

    await db.put(
        key,
        TransactionModel(
            type: obj.type,
            category: obj.category,
            amount: obj.amount,
            date: obj.date,
            note: obj.note,
            id: key));
    refresh();
  }

  Future<void> refresh() async {
    final list = await getAllTransaction();
    transactionlistnotifier.value.clear();
    transactionlistnotifier.value.addAll(list.reversed);
    transactionlistnotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> deleteitem(int key) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    db.delete(key);

    refresh();
  }

  @override
  Future<void> edittransaction(TransactionModel value) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    await db.put(
        value.id,
        TransactionModel(
            id: value.id,
            type: value.type,
            category: value.category,
            amount: value.amount,
            date: value.date,
            note: value.note));

    refresh();
  }

  @override
  Future<void> reset() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    final db2 = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await db.clear();
    await db2.clear();
    refresh();
  }

  @override
  Future<void> checkNotification() async {
    final db = await Hive.openBox<bool>('boolcheck');
  }
}
