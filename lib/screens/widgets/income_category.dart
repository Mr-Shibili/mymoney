import 'package:flutter/material.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/screens/widgets/alert_dialogue.dart';

import 'package:mymoney/screens/widgets/global_widgets.dart';

class InocomeCategory extends StatefulWidget {
  const InocomeCategory(
      {required this.listner, required this.myitems, super.key});

  final ValueNotifier<List<String>> listner;
  final List<String> myitems;

  @override
  State<InocomeCategory> createState() => _InocomeCategoryState();
}

class _InocomeCategoryState extends State<InocomeCategory> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomecategorylistner,
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
                    showDialog(
                        context: context,
                        builder: (context) => Alertdialogueadd(
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
