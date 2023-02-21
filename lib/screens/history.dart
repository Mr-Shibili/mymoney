import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/model/category/transaction_model.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';
import 'package:mymoney/screens/widgets/history_list.dart';
import '../theme/color_theme.dart';

//ValueNotifier<List<TransactionModel>> searchText = ValueNotifier([]);

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Icon customsearch = const Icon(Icons.search);
  Widget customwidget = const Text('search');
  Widget title = const Text('History');
  @override
  void initState() {
    super.initState();
    Transactiondb.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: title,
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: true,
            backgroundColor: ColorTheme.primaryColor,
            actions: [
              IconButton(
                  icon: customsearch,
                  onPressed: () {
                    setState(() {
                      if (customsearch.icon == Icons.search) {
                        customsearch = const Icon(Icons.close);
                        title = SizedBox(
                          height: 50,
                          child: TextField(
                            onChanged: (value) {
                              filterSearchResults(value);
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Search....',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        customsearch = const Icon(Icons.search);
                        title = Text(
                          'History',
                          style: CustomTextStyles.titleText
                              .copyWith(color: Colors.white),
                        );
                      }
                    });
                  })
            ]),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: ColorTheme.primaryColor,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(40))),
                child: Row(children: [
                  const Spacer(),
                  CustomChoice(
                    selectcolor: ColorTheme.whiteColor,
                    backcolor: ColorTheme.primaryColor,
                  ),
                  IconButton(
                      onPressed: () {
                        filterdate();
                      },
                      icon: Icon(
                        Iconsax.calendar_1,
                        color: ColorTheme.whiteColor,
                        size: 30,
                      )),
                  const SizedBox(width: 20)
                ]),
              ),
            ),
            Expanded(flex: 9, child: HistoryList()),
          ],
        ));
  }

  Future<void> filterdate() async {
    final selectedtemp = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now());

    final listData = await Transactiondb.instance.getAllTransaction();

    if (selectedtemp == null) {
      return;
    } else {
      var selectdate = selectedtemp.start;
      var enddate = selectedtemp.end;
      final result = listData.where((item) {
        return item.date
                .isAfter(selectdate.subtract(const Duration(days: 1))) &&
            item.date.isBefore(enddate.add(const Duration(days: 1)));
      }).toList();
      Transactiondb.instance.transactionlistnotifier.value.clear();
      Transactiondb.instance.transactionlistnotifier.value.addAll(result);
      Transactiondb.instance.transactionlistnotifier.notifyListeners();
      log(result.toString());
    }
  }

  void filterSearchResults(String query) async {
    final listData = await Transactiondb.instance.getAllTransaction();

    if (query.isEmpty) {
      Transactiondb.instance.transactionlistnotifier.value.clear();
      Transactiondb.instance.transactionlistnotifier.value.addAll(listData);
      Transactiondb.instance.transactionlistnotifier.notifyListeners();
    } else {
      Transactiondb.instance.transactionlistnotifier.value.clear();
      final result = listData
          .where((TransactionModel item) => item.category
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      Transactiondb.instance.transactionlistnotifier.value.addAll(result);
      Transactiondb.instance.transactionlistnotifier.notifyListeners();
    }
  }
}
