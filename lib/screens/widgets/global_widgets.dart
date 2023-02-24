import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/model/category/category.dart';

import 'package:mymoney/theme/color_theme.dart';

class CustomTextStyles {
  static TextStyle titleText = TextStyle(
      fontFamily: 'Alegreya Sans', fontSize: 28, color: ColorTheme.blackColor);
  static TextStyle h2Text = TextStyle(
      fontFamily: 'Alegreya Sans', fontSize: 19, color: ColorTheme.blackColor);
  static TextStyle h3Text = TextStyle(
      fontFamily: 'Alegreya Sans', fontSize: 12, color: ColorTheme.blackColor);
  static TextStyle h4Text = TextStyle(
      fontFamily: 'Alegreya Sans', fontSize: 9, color: ColorTheme.primaryColor);
}

class CustomChoice extends StatefulWidget {
  const CustomChoice({
    this.isDropDown = true,
    super.key,
    required this.selectcolor,
    required this.backcolor,
  });
  final Color selectcolor;
  final Color backcolor;
  final bool isDropDown;
  @override
  State<CustomChoice> createState() => _CustomChoiceState();
}

class _CustomChoiceState extends State<CustomChoice> {
  int? _value;
  final List _date = ['D', 'W', 'M', 'Y'];
  List<String> item = ['All', 'Expense', 'Income'];
  String dropdownValue = 'All';
  @override
  Widget build(BuildContext context) {
    //
    return Row(
      children: [
        !widget.isDropDown
            ? SizedBox()
            : Container(
                alignment: Alignment.center,
                height: 35,
                width: 120,
                decoration: BoxDecoration(
                    color: ColorTheme.whiteColor,
                    border: Border.all(
                        color: ColorTheme.whiteColor, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(30)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: const Text('Select'),
                    value: dropdownValue,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                        log(value);
                        seperated(value);
                      });
                    },
                    items: item.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List<Widget>.generate(
            4,
            (int index) {
              return SizedBox(
                height: 35,
                child: ChoiceChip(
                  selectedColor: widget.selectcolor,
                  backgroundColor: widget.backcolor,
                  label: Text(_date[index], style: CustomTextStyles.h3Text),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : 0;
                      choices(_value!);
                    });
                  },
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Future<void> choices(int selectedchoice) async {
    final listData = await Transactiondb.instance.getAllTransaction();
    final datenow = DateTime.now();
    int period = 0;

    if (selectedchoice == null) {
      return;
    } else {
      switch (selectedchoice) {
        case 0:
          period = 0;
          break;
        case 1:
          period = 7;
          break;
        case 2:
          period = 30;
          break;
        case 3:
          period = 365;
          break;
        default:
          period = 0;
      }

      final result = listData.where((item) {
        return item.date
            .isAfter(datenow.subtract(Duration(days: period, hours: 12)));
      }).toList();

      Transactiondb.instance.transactionlistnotifier.value.clear();
      Transactiondb.instance.transactionlistnotifier.value.addAll(result);
      Transactiondb.instance.transactionlistnotifier.notifyListeners();
      log(result.toString());
    }
  }

  Future<void> seperated(String selected) async {
    final listData = await Transactiondb.instance.getAllTransaction();
    final result = listData.where(
      (data) {
        // log(listData.toString());
        if (selected == 'Expense') {
          return data.category.type == CategoryType.expense;
        } else if (selected == 'Income') {
          return data.category.type == CategoryType.income;
        } else {
          return data == data;
        }
      },
    ).toList();
    Transactiondb.instance.transactionlistnotifier.value.clear();
    Transactiondb.instance.transactionlistnotifier.value.addAll(result);
    Transactiondb.instance.transactionlistnotifier.notifyListeners();
    print(result.toString());
  }
}
