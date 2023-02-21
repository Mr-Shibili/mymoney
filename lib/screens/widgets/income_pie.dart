import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:mymoney/screens/widgets/global_widgets.dart';

class IncomePie extends StatefulWidget {
  const IncomePie({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(
              'Income',
              style: CustomTextStyles.h2Text,
            ),
            Row(
              children: <Widget>[
                // const SizedBox(
                //   height: 18,
                // ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.4,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Indicator(
                      color: const Color(0xff0293ee),
                      text: 'Salary',
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: const Color(0xfff8b250),
                      text: 'Business 1',
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: const Color(0xff845bef),
                      text: 'Business 2',
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: const Color(0xff13d38e),
                      text: 'Fourth',
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '35%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }

  // ignore: non_constant_identifier_names
  Widget Indicator({required Color color, required String text}) {
    return Row(
      children: [
        Icon(
          Icons.square,
          color: color,
        ),
        Text(text),
      ],
    );
  }
}
