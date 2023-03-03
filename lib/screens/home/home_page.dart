import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/screens/home/charts.dart';
import 'package:mymoney/screens/home/green_list.dart';
import 'package:mymoney/theme/color_theme.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? bahu;

  Future<double?> total() async {
    final listData = await Transactiondb.instance.getAllTransaction();
    var total;
    for (var element in CategoryDb.instance.expensecategorylistner.value) {
      total = listData
          .where((data) {
            return data.category.type == CategoryType.expense;
          })
          .toList()
          .fold<double>(
              0, (previousValue, element) => previousValue + element.amount);
    }

    log(total.toString());
    return total;
  }

  void callTotal() async {
    bahu = await total();
    setState(() {});
    log(bahu.toString() + 'bahu');
  }

  @override
  void initState() {
    super.initState();

    callTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(15),
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
                        '',
                        style: CustomTextStyles.h2Text.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.green),
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
                        bahu.toString(),
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
          BarChartSample2(),
        ],
      )),
    );
  }
}
