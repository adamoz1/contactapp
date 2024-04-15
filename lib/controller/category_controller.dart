import 'package:contactapp/model/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categoery_data = [].obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() {
    categoery_data.value = categoryModel.getList();
  }

  void addData(value) {
    var transection = categoryModel.addCategory(value, categoery_data.length);
    if (transection) {
      getData();
    }
  }

  void updateData(value, index) {
    print(value);
    print(index);
    categoryModel.updateCategory(value, index);
    getData();
  }

  void deleteData(index) {
    categoryModel.delCategory(index);
    getData();
  }
}
