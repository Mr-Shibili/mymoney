import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';

class ExpensePie extends StatefulWidget {
  const ExpensePie({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

List<String> valname = [];
List<double> val = [];
List<Color> color = [];

class PieChart2State extends State {
  int touchedIndex = -1;

  double sum = 0;

  @override
  void initState() {
    chart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(valname.length.toString());
    return AspectRatio(
      aspectRatio: 1.5,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(
              'Incomes',
              style: CustomTextStyles.h2Text,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 20,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 150,
                  child: ListView.builder(
                    itemCount: valname.length,
                    itemBuilder: (context, index) =>
                        valname.isEmpty || color.isEmpty
                            ? const SizedBox()
                            : indicator(
                                color: color[index],
                                text: Text(valname[index])),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(valname.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      var value = percentage(val[i]);
      var per = value.roundToDouble().toInt();
      return PieChartSectionData(
        color: color[i],
        value: value,
        title: '$per%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    });
  }

  Future<void> chart() async {
    valname.clear();
    val.clear();

    final listData = await Transactiondb.instance.getAllTransaction();
    setState(() {
      final expenselist = listData.where((data) {
        return data.category.type == CategoryType.expense;
      }).toList();
      for (var element in CategoryDb.instance.expensecategorylistner.value) {
        final ans = expenselist
            .where((e) => e.category.name == element.name)
            .toList()
            .fold<double>(
                0, (previousValue, element) => previousValue + element.amount);
        valname.add(element.name);
        val.add(ans);
        sum += ans;
      }
    });
    color =
        List.generate(valname.length, (index) => Colors.primaries[index * 2]);
    log(color.length.toString() + 'ojoojo');
    //Transactiondb.instance.transactionlistnotifier.value.clear();
    //Transactiondb.instance.transactionlistnotifier.value.addAll(sorted);
  }

  double percentage(double amount) {
    double result = (amount / sum) * 100;
    return result;
  }

  Widget indicator({required Color color, required Widget text}) {
    return Row(
      children: [
        Icon(
          Icons.square,
          color: color,
        ),
        text,
      ],
    );
  }
}
