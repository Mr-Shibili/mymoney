import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/screens/home/barchart.dart';

import 'package:mymoney/screens/home/green_list.dart';
import 'package:mymoney/screens/splash_screen.dart';
import 'package:mymoney/theme/color_theme.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';

import '../../model/category/transaction_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? expenseTotal;
  double? incomeTotal;
  List<double> temp = [];
  int highval = 0;
  Future<void> total() async {
    final listData = await Transactiondb.instance.getAllTransaction();

    for (var element in listData) {
      expenseTotal = listData
          .where((data) {
            return data.category.type == CategoryType.expense;
          })
          .toList()
          .fold<double>(
              0, (previousValue, element) => previousValue + element.amount);
      incomeTotal = listData
          .where((data) {
            return data.category.type == CategoryType.income;
          })
          .toList()
          .fold<double>(
              0, (previousValue, element) => previousValue + element.amount);
    }
  }

  @override
  void initState() {
    super.initState();

    chartdata();
    total().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo-color_preview_rev_1.png',
                    height: 30,
                    width: 100,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Iconsax.profile_add,
                        color: Colors.blue,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Refer a friend',
                            style: CustomTextStyles.h4Text.copyWith(
                              color: ColorTheme.buttonColor,
                            )),
                      )
                    ],
                  )
                ],
              ),
              const Greenboard(),
              const SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 50,
                        width: 8,
                        decoration: BoxDecoration(
                            color: ColorTheme.primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Income',
                            style: CustomTextStyles.h2Text,
                          ),
                          Text(
                            '₹$incomeTotal',
                            style: CustomTextStyles.h2Text.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 8,
                        decoration: BoxDecoration(
                            color: ColorTheme.primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Spending',
                            style: CustomTextStyles.h2Text,
                          ),
                          Text(
                            '₹$expenseTotal',
                            style: CustomTextStyles.h2Text.copyWith(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              temp.isEmpty
                  ? SizedBox()
                  : SizedBox(
                      height: 275,
                      child: BarChart(
                        data: temp,
                      )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> chartdata() async {
    temp.clear();
    final listData = await Transactiondb.instance.getAllTransaction();
    List<TransactionModel>? expenselist;

    final today = DateTime.now();
    expenselist = listData.where((data) {
      return data.category.type == CategoryType.expense &&
          data.date.isAfter(today.subtract(const Duration(days: 7)));
    }).toList();

    for (var i = 1; i <= 7; i++) {
      double te = expenselist
          .where((data) {
            return data.date.weekday == i;
          })
          .toList()
          .fold(
              0, (previousValue, item) => previousValue + item.amount.toInt());

      temp.add(te);
    }

    highval = temp.reduce((value, element) => max(value, element)).toInt();

    debugPrint(highval.toString());
  }
}
