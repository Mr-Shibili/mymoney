import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/model/category/transaction_model.dart';
import 'package:mymoney/screens/widgets/expense_pie.dart';

import 'package:mymoney/screens/widgets/global_widgets.dart';

import '../../theme/color_theme.dart';

class Greenboard extends StatefulWidget {
  const Greenboard({super.key});

  @override
  State<Greenboard> createState() => _GreenboardState();
}

class _GreenboardState extends State<Greenboard> {
  ValueNotifier<List<TransactionModel>> list = ValueNotifier([]);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  Future<void> get() async {
    final val = await Transactiondb.instance.getAllTransaction();
    list.value.addAll(val);
    list.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          width: 160,
          height: 190,
          decoration: BoxDecoration(
              color: ColorTheme.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: ValueListenableBuilder(
              valueListenable: list,
              builder: (context, newlist, _) {
                // final newlist.last =  newlist.last;
                return list.value.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Today',
                                style: CustomTextStyles.h2Text.copyWith(
                                    color: ColorTheme.whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              // Icon(
                              //   Icons.arrow_forward_ios_rounded,
                              //   color: ColorTheme.seconderyColor,
                              //   size: 15,
                              // )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Recent spend',
                            style: CustomTextStyles.h3Text
                                .copyWith(color: ColorTheme.seconderyColor),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              newlist.last.type == CategoryType.income
                                  ? const Icon(
                                      Icons.arrow_circle_down,
                                      size: 40,
                                      color: Color.fromARGB(255, 18, 121, 4),
                                    )
                                  : const Icon(
                                      Icons.arrow_circle_up,
                                      size: 40,
                                      color: Color.fromARGB(255, 213, 30, 17),
                                    ),
                              SizedBox(
                                width: 50,
                                child: Text(
                                  newlist.last.category.name,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                ),
                              ),
                              Text(
                                '₹${newlist.last.amount.toInt()}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text('Category',
                              style: CustomTextStyles.h3Text
                                  .copyWith(color: ColorTheme.seconderyColor)),
                          const SizedBox(height: 5),
                          newlist.last.type == CategoryType.income
                              ? const Text('Income',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12))
                              : const Text('Expense',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12))
                        ],
                      );
              }),
        ),
        const SizedBox(width: 20),
        Container(
          width: 160,
          height: 190,
          decoration: BoxDecoration(
              color: ColorTheme.yellowColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: CustomTextStyles.h2Text.copyWith(
                            color: ColorTheme.whiteColor,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: valname.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 70,
                          child: Text(
                            valname[index],
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text('₹${val[index].toInt()}',
                            style: CustomTextStyles.h3Text
                                .copyWith(fontSize: 12, fontFamily: 'Raleway')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
