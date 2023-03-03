import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/model/category/transaction_model.dart';

import 'package:mymoney/screens/widgets/global_widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../theme/color_theme.dart';

class Greenboard extends StatefulWidget {
  const Greenboard({super.key});

  @override
  State<Greenboard> createState() => _GreenboardState();
}

class _GreenboardState extends State<Greenboard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Transactiondb.instance.transactionlistnotifier,
        builder: (context, List<TransactionModel> newlist, _) {
          final value = newlist.first;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                width: 160,
                height: 200,
                decoration: BoxDecoration(
                    color: ColorTheme.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Today',
                          style: CustomTextStyles.h2Text
                              .copyWith(color: ColorTheme.whiteColor),
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
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        value.type == CategoryType.income
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
                        Text(value.category.name,
                            style: CustomTextStyles.h3Text
                                .copyWith(color: ColorTheme.whiteColor)),
                        Text(
                          '${value.amount.toInt()}',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 35),
                    Text('Category',
                        style: CustomTextStyles.h3Text
                            .copyWith(color: ColorTheme.seconderyColor)),
                    const SizedBox(height: 5),
                    value.type == CategoryType.income
                        ? const Text('Income',
                            style: TextStyle(color: Colors.white, fontSize: 12))
                        : const Text('Expense',
                            style: TextStyle(color: Colors.white, fontSize: 12))
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 160,
                height: 200,
                decoration: BoxDecoration(
                    color: ColorTheme.yellowColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Categories',
                                style: CustomTextStyles.h2Text
                                    .copyWith(color: ColorTheme.whiteColor)),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: ColorTheme.seconderyColor,
                            )
                          ],
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              const CircleAvatar(
                                minRadius: 14,
                              ),
                              Column(
                                children: [
                                  const Text('Food'),
                                  const SizedBox(height: 5),
                                  LinearPercentIndicator(
                                    width: 75.0,
                                    lineHeight: 5.0,
                                    percent: 0.5,
                                    barRadius: const Radius.circular(10),
                                    progressColor: const Color.fromARGB(
                                        255, 253, 253, 252),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('₹500',
                                      style: CustomTextStyles.h3Text.copyWith(
                                          fontSize: 12, fontFamily: 'Raleway')),
                                  const SizedBox(height: 4),
                                  Text('30%',
                                      style: CustomTextStyles.h3Text.copyWith(
                                          fontSize: 10,
                                          fontFamily: 'Raleway',
                                          color: ColorTheme.whiteColor))
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              const CircleAvatar(
                                minRadius: 14,
                              ),
                              Column(
                                children: [
                                  const Text('Food'),
                                  const SizedBox(height: 6),
                                  LinearPercentIndicator(
                                    width: 75.0,
                                    lineHeight: 5.0,
                                    percent: 0.5,
                                    barRadius: const Radius.circular(10),
                                    progressColor: const Color.fromARGB(
                                        255, 253, 253, 252),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('₹500',
                                      style: CustomTextStyles.h3Text.copyWith(
                                          fontSize: 12, fontFamily: 'Raleway')),
                                  const SizedBox(height: 4),
                                  Text('30%',
                                      style: CustomTextStyles.h3Text.copyWith(
                                          fontSize: 10,
                                          fontFamily: 'Raleway',
                                          color: ColorTheme.whiteColor))
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              const CircleAvatar(
                                minRadius: 14,
                              ),
                              Column(
                                children: [
                                  const Text('Food'),
                                  const SizedBox(height: 5),
                                  LinearPercentIndicator(
                                    width: 75.0,
                                    lineHeight: 5.0,
                                    percent: 0.5,
                                    barRadius: const Radius.circular(10),
                                    progressColor: const Color.fromARGB(
                                        255, 253, 253, 252),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('₹500',
                                      style: CustomTextStyles.h3Text.copyWith(
                                          fontSize: 12, fontFamily: 'Raleway')),
                                  const SizedBox(height: 4),
                                  Text('30%',
                                      style: CustomTextStyles.h3Text.copyWith(
                                          fontSize: 10,
                                          fontFamily: 'Raleway',
                                          color: ColorTheme.whiteColor))
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          );
        });
  }
}
