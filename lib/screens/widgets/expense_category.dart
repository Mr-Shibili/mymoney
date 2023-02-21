import 'package:flutter/material.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/screens/widgets/alert_dialogue.dart';

import 'package:mymoney/screens/widgets/global_widgets.dart';

class ExpenseCategory extends StatefulWidget {
  const ExpenseCategory(
      {required this.listner, required this.myitems, super.key});

  final ValueNotifier<List<String>> listner;
  final List<String> myitems;
  @override
  State<ExpenseCategory> createState() => _ExpenseCategoryState();
}

class _ExpenseCategoryState extends State<ExpenseCategory> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().expensecategorylistner,
      builder: (BuildContext ctx, List<CategoryModel> newlist, _) =>
          ListView.builder(
        itemCount: newlist.length,
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  newlist[index].name,
                  style: CustomTextStyles.h2Text,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // CategoryDb.instance.updateCategory(index, newlist[index]);
                    showDialog(
                        context: context,
                        builder: (context) => Alertdialogueadd(
                              type: newlist[index].type,
                              context: ctx,
                              isupdate: true,
                              data: newlist[index],
                              index: index,
                            ));
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                    onPressed: () {
                      CategoryDb.instance.deletecategory(newlist[index].key!);
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
