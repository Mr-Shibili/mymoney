import 'package:flutter/material.dart';
import 'package:mymoney/theme/color_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChart extends StatelessWidget {
  const BarChart({super.key, required this.data});
  final List<double> data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SfCartesianChart(
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                series: <ColumnSeries<SalesData, String>>[
          ColumnSeries<SalesData, String>(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: ColorTheme.primaryColor,
              // Bind data source
              dataSource: <SalesData>[
                SalesData('Mon', data[0]),
                SalesData('Tue', data[1]),
                SalesData('Wed', data[2]),
                SalesData('Thu', data[3]),
                SalesData('Fri', data[4]),
                SalesData('Sat', data[5]),
                SalesData('Sun', data[6])
              ],
              xValueMapper: (SalesData sales, _) => sales.amount,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ])));
  }
}

class SalesData {
  SalesData(this.amount, this.sales);
  final String amount;
  final double sales;
}
