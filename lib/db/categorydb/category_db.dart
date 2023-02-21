import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mymoney/model/category/category.dart';

const CATEGORY_DB_NAME = 'category_database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deletecategory(int index);
  Future<void> updateCategory(CategoryModel val);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb.internal();
  static CategoryDb instance = CategoryDb.internal();

  ValueNotifier<List<CategoryModel>> incomecategorylistner = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expensecategorylistner = ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final box = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    final key = await box.add(value);
    final val = box.get(key);

    await box.put(key,
        CategoryModel(key: key, name: val!.name, type: val.type, id: val.id));

    refreshUI();
  }

  factory CategoryDb() {
    return instance;
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDb.values.toList();
  }

  Future<void> refreshUI() async {
    final allcategories = await getCategories();
    incomecategorylistner.value.clear();
    expensecategorylistner.value.clear();
    Future.forEach(allcategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomecategorylistner.value.add(category);
      } else {
        expensecategorylistner.value.add(category);
      }
    });

    incomecategorylistner.notifyListeners();
    expensecategorylistner.notifyListeners();
  }

  @override
  Future<void> deletecategory(int key) async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDb.delete(key);
    refreshUI();
  }

  @override
  Future<void> updateCategory(CategoryModel val) async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDb.put(val.key!, val);
    await refreshUI();
  }
}
