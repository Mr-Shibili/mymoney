import 'package:hive_flutter/hive_flutter.dart';
import 'package:mymoney/model/category/category.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 3)
enum PaymentMode {
  @HiveField(0)
  cash,
  @HiveField(1)
  card,
  @HiveField(2)
  online,
  @HiveField(3)
  upi
}

@HiveType(typeId: 4)
class TransactionModel {
  @HiveField(0)
  final CategoryType type;
  @HiveField(1)
  final CategoryModel category;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String note;
  @HiveField(5)
  final PaymentMode? mode;
  @HiveField(6)
  int? id;

  TransactionModel(
      {required this.type,
      required this.category,
      required this.amount,
      required this.date,
      required this.note,
      this.mode,
      this.id});
}
