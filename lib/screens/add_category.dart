import 'package:flutter/material.dart';
import 'package:mymoney/db/categorydb/category_db.dart';
import 'package:mymoney/model/category/category.dart';
import 'package:mymoney/screens/widgets/alert_dialogue.dart';
import 'package:mymoney/screens/widgets/expense_category.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';
import 'package:mymoney/screens/widgets/income_category.dart';
import '../theme/color_theme.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory>
    with SingleTickerProviderStateMixin {
  final List<String> myitems = [];
  final categoryController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  ValueNotifier<List<String>> categorylistner = ValueNotifier([]);
  int _selectedRadio = 0;
  late TabController tabcontroller;
  ValueNotifier<CategoryType> typenotifier =
      ValueNotifier(CategoryType.expense);

  @override
  void initState() {
    tabcontroller = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  void dispose() {
    tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add category',
            style: CustomTextStyles.titleText.copyWith(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 0,
        backgroundColor: ColorTheme.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topCenter,
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorTheme.primaryColor,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(40))),
            ),
          ),
          Expanded(
            flex: 1,
            child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                controller: tabcontroller,
                tabs: [
                  Text(
                    'Income',
                    style: CustomTextStyles.h2Text,
                  ),
                  Text(
                    'Expense',
                    style: CustomTextStyles.h2Text,
                  )
                ]),
          ),
          Expanded(
              flex: 12,
              child: TabBarView(controller: tabcontroller, children: [
                InocomeCategory(listner: categorylistner, myitems: myitems),
                ExpenseCategory(
                  listner: categorylistner,
                  myitems: myitems,
                )
              ]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // alertdials(context);
            showDialog(
                context: context,
                builder: (context) => Alertdialogueadd(
                      context: context,
                    ));
          },
          child: const Icon(Icons.add)),
    );
  }

  // Future alertdials(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => Form(
  //             key: formkey,
  //             child: SimpleDialog(
  //               title: Text(
  //                 'Add category',
  //                 style: CustomTextStyles.h2Text,
  //                 textAlign: TextAlign.center,
  //               ),
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(20.0),
  //                   child: TextFormField(
  //                     decoration:
  //                         const InputDecoration(border: OutlineInputBorder()),
  //                     controller: categoryController,
  //                     validator: (categoryController) {
  //                       if (categoryController == null ||
  //                           categoryController.isEmpty) {
  //                         return 'Please enter some text';
  //                       }
  //                       return null;
  //                     },
  //                   ),
  //                 ),
  //                 ValueListenableBuilder(
  //                   valueListenable: typenotifier,
  //                   builder: (context, CategoryType newCategory, _) => Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: [
  //                       Radio<CategoryType>(
  //                         activeColor: ColorTheme.buttonColor,
  //                         value: CategoryType.expense,
  //                         groupValue: typenotifier.value,
  //                         onChanged: ((value) {
  //                           if (value == null) {
  //                             return;
  //                           }
  //                           typenotifier.value = value;
  //                           typenotifier.notifyListeners();
  //                         }),
  //                       ),
  //                       Text(
  //                         'Expense',
  //                         style: CustomTextStyles.h2Text,
  //                       ),
  //                       Radio(
  //                         activeColor: ColorTheme.buttonColor,
  //                         value: CategoryType.income,
  //                         groupValue: typenotifier.value,
  //                         onChanged: (value) {
  //                           if (value == null) {
  //                             return;
  //                           }
  //                           typenotifier.value = value;
  //                           typenotifier.notifyListeners();
  //                         },
  //                       ),
  //                       Text(
  //                         'Income',
  //                         style: CustomTextStyles.h2Text,
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(15.0),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       ElevatedButton(
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                           child: const Text('Cancel')),
  //                       ElevatedButton(
  //                           onPressed: () {
  //                             if (formkey.currentState!.validate()) {
  //                               // If the form is valid, display a snackbar. In the real world,
  //                               // you'd often call a server or save the information in a database.
  //                               //myitems.add(categoryController.text);
  //                               //categorylistner.value
  //                               //    .add(categoryController.text);
  //                               CategoryDb.instance.insertCategory(
  //                                   CategoryModel(
  //                                       id: DateTime.now()
  //                                           .millisecondsSinceEpoch
  //                                           .toString(),
  //                                       name: categoryController.text,
  //                                       type: typenotifier.value));
//                               categoryController.clear();

  //                             Navigator.pop(context);
  //                             }
  //                           },
  //                           child: const Text('add'))
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ));
  // }
}
