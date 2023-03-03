import 'package:flutter/material.dart';

import 'package:mymoney/screens/widgets/global_widgets.dart';
import 'package:mymoney/screens/widgets/income_pie.dart';
import '../theme/color_theme.dart';
import 'widgets/expense_pie.dart';

class Statitics extends StatefulWidget {
  const Statitics({super.key});

  @override
  State<Statitics> createState() => _StatiticsState();
}

class _StatiticsState extends State<Statitics> {
  int touchedIndex = -1;

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
}
