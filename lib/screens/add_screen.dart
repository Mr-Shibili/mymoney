import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/model/category/transaction_model.dart';
import 'package:mymoney/screens/add_category.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';
import 'package:mymoney/screens/widgets/history_list.dart';
import 'package:mymoney/screens/widgets/notification_class.dart';
import 'package:mymoney/theme/color_theme.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

final noteTextEditingController = TextEditingController();
final amountTextEditingController = TextEditingController();

class _AddScreenState extends State<AddScreen> {
  CategoryType? selectedcategorytype;
  CategoryModel? selectedcategorymodel;
  String text = "";
  DateTime date = DateTime.now();
  String? categoryid;
  final List mode = ['Cash', 'Card', 'Online', 'UPI'];
  DateTime selectdate = DateTime.now();

  @override
  void initState() {
    Transactiondb.instance.refresh();
    initFunction();
    selectedcategorytype = CategoryType.expense;

    super.initState();
  }

  initFunction() async {
    await CategoryDb.instance.refreshUI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add item',
            style: CustomTextStyles.titleText.copyWith(
              color: ColorTheme.whiteColor,
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  color: ColorTheme.primaryColor,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 26),
                        Radio(
                          activeColor: ColorTheme.whiteColor,
                          value: CategoryType.expense,
                          groupValue: selectedcategorytype,
                          onChanged: (val) {
                            setState(() {
                              selectedcategorytype = CategoryType.expense;
                              categoryid = null;
                            });
                          },
                        ),
                        Text(
                          'Expense',
                          style: CustomTextStyles.h2Text,
                        ),
                        Radio(
                          activeColor: ColorTheme.whiteColor,
                          value: CategoryType.income,
                          groupValue: selectedcategorytype,
                          onChanged: (val) {
                            setState(() {
                              selectedcategorytype = CategoryType.income;
                              categoryid = null;
                            });
                          },
                        ),
                        Text(
                          'Income',
                          style: CustomTextStyles.h2Text,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 40),
                        Container(
                          width: 150,
                          height: 35,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: DropdownButton<String>(
                            value: categoryid,
                            items: (selectedcategorytype == CategoryType.expense
                                    ? CategoryDb().expensecategorylistner
                                    : CategoryDb().incomecategorylistner)
                                .value
                                .map((e) {
                              return DropdownMenuItem(
                                  onTap: (() {
                                    selectedcategorymodel = e;
                                  }),
                                  value: e.id,
                                  child: Text(e.name));
                            }).toList(),
                            hint: const Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            onChanged: (selectedvalue) {
                              setState(() {
                                categoryid = selectedvalue;
                              });
                            },
                            underline: const SizedBox(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddCategory()));
                            },
                            child: Text('Add category',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorTheme.lightblueColor))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 35,
                          child: TextFormField(
                            controller: amountTextEditingController,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              icon: const Icon(
                                Icons.currency_rupee,
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              hintText: 'Amount',
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton.icon(
                            onPressed: () async {
                              final selectedtemp = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 30)),
                                  lastDate: DateTime.now());
                              if (selectedtemp == null) {
                                return;
                              } else {
                                setState(() {
                                  selectdate = selectedtemp;
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Color.fromARGB(255, 22, 1, 255),
                            ),
                            label: Text(
                              selectdate == null
                                  ? 'Select date'
                                  : DateFormat.yMMMd().format(selectdate),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 22, 1, 255),
                              ),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Note : '),
                        Expanded(
                          child: SizedBox(
                            width: 150,
                            height: 35,
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: noteTextEditingController,
                              textAlignVertical: TextAlignVertical.bottom,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                hintText: 'Hint..',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        onPressed: () {
                          addTransaction().then((value) {
                            setState(() {});
                            noteTextEditingController.clear();
                            amountTextEditingController.clear();
                          });
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Text(
                          'Save',
                          style: CustomTextStyles.h2Text
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Text(
                    'Recent',
                    style: CustomTextStyles.titleText,
                  ),
                  // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                ],
              ),
            ),
            HistoryList(
              selectedcategorymodel: selectedcategorymodel,
              selectedcategorytype: selectedcategorytype,
              selectdate: selectdate,
            )
          ],
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final notetext = noteTextEditingController.text;
    final amounttext = amountTextEditingController.text;
    if (notetext.isEmpty) {
      return;
    }
    if (amounttext.isEmpty) {
      return;
    }

    if (selectedcategorymodel == null) {
      return;
    }
    if (selectdate == null) {
      return;
    }
    if (mode == null) {
      return;
    }
    final parsedamount = double.tryParse(amounttext);
    if (parsedamount == null) {
      return;
    }
    final model = TransactionModel(
        type: selectedcategorytype!,
        category: selectedcategorymodel!,
        amount: parsedamount,
        date: selectdate,
        note: notetext);
    Transactiondb.instance.addTransaction(model);

    final snak = SnackBar(
      backgroundColor: ColorTheme.primaryColor,
      content: const Text('Success'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snak);
  }
}
