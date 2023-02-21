import 'package:flutter/material.dart';

import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';
import 'package:mymoney/theme/color_theme.dart';

class Alertdialogueadd extends StatefulWidget {
  const Alertdialogueadd(
      {super.key,
      required this.context,
      this.type,
      this.isupdate = false,
      this.index,
      this.data});
  final context;

  final CategoryType? type;
  final bool isupdate;
  final int? index;
  final CategoryModel? data;

  @override
  State<Alertdialogueadd> createState() => _AlertdialogueaddState();
}

class _AlertdialogueaddState extends State<Alertdialogueadd> {
  late TabController tabcontroller;

  ValueNotifier<CategoryType> typenotifier =
      ValueNotifier(CategoryType.expense);

  final categoryController = TextEditingController();
  final typeController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  ValueNotifier<List<String>> categorylistner = ValueNotifier([]);

  @override
  void initState() {
    if (widget.isupdate) {
      categoryController.text = widget.data!.name;
      typenotifier.value = widget.data!.type;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: SimpleDialog(
        title: Text(
          'Add category',
          style: CustomTextStyles.h2Text,
          textAlign: TextAlign.center,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              controller: categoryController,
              validator: (categoryController) {
                if (categoryController == null || categoryController.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: typenotifier,
            builder: (context, CategoryType newCategory, _) => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<CategoryType>(
                  activeColor: ColorTheme.buttonColor,
                  value: CategoryType.expense,
                  groupValue: typenotifier.value,
                  onChanged: ((value) {
                    if (value == null) {
                      return;
                    }
                    typenotifier.value = value;
                    typenotifier.notifyListeners();
                  }),
                ),
                Text(
                  'Expense',
                  style: CustomTextStyles.h2Text,
                ),
                Radio(
                  activeColor: ColorTheme.buttonColor,
                  value: CategoryType.income,
                  groupValue: typenotifier.value,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    typenotifier.value = value;
                    typenotifier.notifyListeners();
                  },
                ),
                Text(
                  'Income',
                  style: CustomTextStyles.h2Text,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        final data = CategoryModel(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            name: categoryController.text,
                            type: typenotifier.value);
                        widget.isupdate != true
                            ? CategoryDb.instance.insertCategory(data)
                            : CategoryDb.instance.updateCategory(CategoryModel(
                                key: widget.data!.key,
                                id: widget.data!.id,
                                name: categoryController.text,
                                type: typenotifier.value));

                        categoryController.clear();

                        Navigator.pop(context);
                      }
                    },
                    child: const Text('add'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
