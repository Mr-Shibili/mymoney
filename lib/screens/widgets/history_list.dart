import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/model/category/transaction_model.dart';
import 'package:mymoney/screens/add_screen.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';
import 'package:mymoney/theme/color_theme.dart';

class HistoryList extends StatefulWidget {
  HistoryList({
    this.selectedcategorytype,
    this.selectdate,
    super.key,
    this.selectedcategorymodel,
    this.search,
  });
  final String? search;
  CategoryType? selectedcategorytype;

  CategoryModel? selectedcategorymodel;
  DateTime? selectdate;

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  ValueNotifier<DateTime?> selectedDate = ValueNotifier(null);
  ValueNotifier<CategoryType> selectedType =
      ValueNotifier(CategoryType.expense);
  ValueNotifier<CategoryModel?> selectedCat = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    selectedDate.value = widget.selectdate;
    if (widget.selectedcategorytype != null) {
      selectedType.value = widget.selectedcategorytype!;
    } else {
      selectedType.value = CategoryType.expense;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Transactiondb.instance.transactionlistnotifier,
      builder: (BuildContext ctx, List<TransactionModel> newlist, _) {
        return newlist.isEmpty
            ? const Center(child: Text('Empty'))
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  newlist.sort((a, b) => b.date.compareTo(a.date));
                  final value = newlist[index];

                  return Card(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  value.category.name,
                                  style: CustomTextStyles.h2Text,
                                ),
                                const Spacer(),
                                Text(DateFormat.yMMMd().format(value.date)),
                                const SizedBox(width: 15)
                              ],
                            ),
                            leading: value.type == CategoryType.income
                                ? const Icon(
                                    Icons.arrow_circle_down,
                                    size: 40,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.arrow_circle_up,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                            subtitle: Row(
                              children: [
                                Text(
                                  '₹${value.amount.toString()}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    amountTextEditingController.text =
                                        value.amount.toString();
                                    noteTextEditingController.text = value.note;
                                    selectedType.value = value.type;
                                    widget.selectedcategorymodel =
                                        value.category;
                                    selectedDate.value = value.date;
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(30),
                                                topLeft: Radius.circular(30))),
                                        context: context,
                                        builder: (ctx) => SizedBox(
                                              height: 380,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    left: 15,
                                                    right: 15,
                                                    bottom: MediaQuery.of(ctx)
                                                        .viewInsets
                                                        .bottom),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'Edit details',
                                                          style:
                                                              CustomTextStyles
                                                                  .titleText,
                                                        ),
                                                        ValueListenableBuilder(
                                                            valueListenable:
                                                                selectedType,
                                                            builder: (context,
                                                                cattype, _) {
                                                              return Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Radio<
                                                                      CategoryType>(
                                                                    activeColor:
                                                                        ColorTheme
                                                                            .buttonColor,
                                                                    value: CategoryType
                                                                        .expense,
                                                                    groupValue:
                                                                        selectedType
                                                                            .value,
                                                                    onChanged:
                                                                        ((value) {
                                                                      if (value ==
                                                                          null) {
                                                                        return;
                                                                      } else {
                                                                        selectedType.value =
                                                                            value;
                                                                        selectedCat.value =
                                                                            null;
                                                                      }
                                                                    }),
                                                                  ),
                                                                  Text(
                                                                    'Expense',
                                                                    style: CustomTextStyles
                                                                        .h2Text,
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Radio(
                                                                    activeColor:
                                                                        ColorTheme
                                                                            .buttonColor,
                                                                    value: CategoryType
                                                                        .income,
                                                                    groupValue:
                                                                        selectedType
                                                                            .value,
                                                                    onChanged:
                                                                        (value) {
                                                                      if (value ==
                                                                          null) {
                                                                        return;
                                                                      } else {
                                                                        selectedType.value =
                                                                            value;
                                                                        selectedCat.value =
                                                                            null;
                                                                      }
                                                                    },
                                                                  ),
                                                                  Text(
                                                                    'Income',
                                                                    style: CustomTextStyles
                                                                        .h2Text,
                                                                  )
                                                                ],
                                                              );
                                                            }),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            ValueListenableBuilder(
                                                                valueListenable:
                                                                    selectedCat,
                                                                builder:
                                                                    (context,
                                                                        cat,
                                                                        _) {
                                                                  return ValueListenableBuilder(
                                                                      valueListenable:
                                                                          selectedType,
                                                                      builder: (context,
                                                                          typee,
                                                                          _) {
                                                                        return DropdownButton<
                                                                            CategoryModel>(
                                                                          value:
                                                                              cat,
                                                                          hint:
                                                                              const Text('Select Category'),
                                                                          elevation:
                                                                              2,
                                                                          style:
                                                                              CustomTextStyles.h2Text,
                                                                          onChanged:
                                                                              (value) {
                                                                            selectedCat.value =
                                                                                value;

                                                                            // This is called when the user selects an item.
                                                                          },
                                                                          items: (typee == CategoryType.income ? CategoryDb.instance.incomecategorylistner : CategoryDb.instance.expensecategorylistner)
                                                                              .value
                                                                              .map((e) {
                                                                            return DropdownMenuItem<CategoryModel>(
                                                                                value: e,
                                                                                child: Text(e.name));
                                                                          }).toList(),
                                                                        );
                                                                      });
                                                                }),
                                                            TextButton.icon(
                                                                onPressed:
                                                                    () async {
                                                                  final selectedtemp = await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          selectedDate
                                                                              .value!,
                                                                      firstDate: DateTime
                                                                              .now()
                                                                          .subtract(const Duration(
                                                                              days:
                                                                                  30)),
                                                                      lastDate:
                                                                          DateTime
                                                                              .now());
                                                                  if (selectedtemp ==
                                                                      null) {
                                                                    return;
                                                                  } else {
                                                                    selectedDate
                                                                            .value =
                                                                        selectedtemp;
                                                                  }
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .calendar_today,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          22,
                                                                          1,
                                                                          255),
                                                                ),
                                                                label:
                                                                    ValueListenableBuilder(
                                                                        valueListenable:
                                                                            selectedDate,
                                                                        builder: (context,
                                                                            datetimm,
                                                                            _) {
                                                                          return Text(
                                                                            DateFormat.yMMMd().format(datetimm!),
                                                                            style:
                                                                                const TextStyle(
                                                                              color: Color.fromARGB(255, 22, 1, 255),
                                                                            ),
                                                                          );
                                                                        }))
                                                          ],
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              amountTextEditingController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      'Amount',
                                                                  border:
                                                                      OutlineInputBorder()),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        TextFormField(
                                                          controller:
                                                              noteTextEditingController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      'Note',
                                                                  border:
                                                                      OutlineInputBorder()),
                                                        ),
                                                        const Divider(),
                                                        SizedBox(
                                                            height: 40,
                                                            width: 200,
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      if (value.id == null ||
                                                                          value
                                                                              .note
                                                                              .isEmpty ||
                                                                          selectedCat.value ==
                                                                              null) {
                                                                        return;
                                                                      } else {
                                                                        final data = TransactionModel(
                                                                            id: value
                                                                                .id,
                                                                            type:
                                                                                selectedType.value,
                                                                            category: selectedCat.value!,
                                                                            amount: double.parse(amountTextEditingController.text),
                                                                            date: selectedDate.value!,
                                                                            note: noteTextEditingController.text);
                                                                        await Transactiondb
                                                                            .instance
                                                                            .edittransaction(
                                                                                data)
                                                                            .then((value) =>
                                                                                Navigator.pop(ctx));
                                                                        amountTextEditingController
                                                                            .clear();
                                                                        noteTextEditingController
                                                                            .clear();
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      'Save',
                                                                      style: CustomTextStyles.h2Text.copyWith(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              20),
                                                                    )))
                                                      ]),
                                                ),
                                              ),
                                            ));
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title:
                                              const Text('Delete transaction'),
                                          content: const Text(
                                              'Do you want to delete Transaction?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  log(value.id.toString());
                                                  Transactiondb.instance
                                                      .deleteitem(value.id!);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Yes')),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('No'))
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
                          )));
                },
                itemCount: newlist.length);
      },
    );
  }
}
