import 'package:contactapp/model/cat.dart';
import 'package:hive/hive.dart';

class CategoryModel {
  late final Box collection;

  getList() {
    print(collection.keys.toList());
    print(collection.values.toList());
    return collection.values.toList();
  }

  addCategory(value, index) {
    if (value == "" || value == null) {
      return false;
    } else {
      Cat val = Cat.fromJson({"category": value});
      collection.add(val);
      // collection.put(index, val);
      return true;
    }
  }

  updateCategory(value, index) {
    print(value);
    print(index);
    Cat c = collection.getAt(index);
    c.category = value;
    print("After updating ${c.category}");
    collection.putAt(index, c);
  }

  delCategory(index) {
    collection.deleteAt(index);
  }
}

CategoryModel categoryModel = CategoryModel();
