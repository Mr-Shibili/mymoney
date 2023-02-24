import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';
import 'package:mymoney/screens/widgets/income_pie.dart';
import '../theme/color_theme.dart';
import 'widgets/expense_pie.dart';

class Statitics extends StatefulWidget {
  const Statitics({super.key});

  @override
  State<Statitics> createState() => _StatiticsState();
}

List<String> valname = [];
List<double> val = [];
List<Color> color = [];

class _StatiticsState extends State<Statitics> {
  int touchedIndex = -1;
  double sum = 0;
  ValueNotifier<double> perValue = ValueNotifier(0);
  Future<void> chart() async {
    final listData = await Transactiondb.instance.getAllTransaction();
    setState(() {
      color =
          List.generate(valname.length, (index) => Colors.primaries[index * 2]);
      valname.clear();
      val.clear();
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
  }

  double percentage(double amount) {
    double result = (amount / sum) * 100;
    return result;
  }

  @override
  void initState() {
    chart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statitics',
            style: CustomTextStyles.titleText.copyWith(color: Colors.white)),
        centerTitle: true,
        //leading: const Icon(Icons.arrow_back),
        elevation: 0,
        backgroundColor: ColorTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
                color: ColorTheme.primaryColor,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(40))),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 8),
                  // Icon(
                  //   Icons.arrow_back,
                  //   color: ColorTheme.whiteColor,
                  // ),
                  Row(children: [
                    const Spacer(),

                    // CustomChoice(
                    //   isDropDown: false,
                    //   selectcolor: ColorTheme.whiteColor,
                    //   backcolor: ColorTheme.primaryColor,
                    // ),
                    // Icon(
                    //   Iconsax.calendar_1,
                    //   color: ColorTheme.whiteColor,
                    // )
                  ]),
                ],
              ),
            ),
          ),
          const Card(
            child: ExpensePie(),
          ),
          const Card(
            child: IncomePie(),
          ),
        ]),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(valname.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      perValue.value = percentage(val[i]);

      return PieChartSectionData(
        color: color[i],
        value: perValue.value,
        title: perValue.value == double.nan || perValue.value == double.infinity
            ? ''
            : perValue.value.toInt().toString() + '%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    });
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
