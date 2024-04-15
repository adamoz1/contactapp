import 'package:contactapp/controller/category_controller.dart';
import 'package:contactapp/model/contact_model.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  var contact_data = [].obs;
  var filter = "".obs;
  var search = "".obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() {
    contact_data.value = contactModel.getList();
  }

  void addData(fname, lname, mobile, email, category, imagePath) {
    var transection = contactModel.addContact(
        fname, lname, mobile, email, category, contact_data.length, imagePath);
    if (transection) {
      getData();
    }
  }

  void updateData(fname, lname, mobile, email, index, imagePath) {
    // print(value);
    print(index);
    contactModel.updateContact(fname, lname, mobile, email, index, imagePath);
    getData();
  }

  void deleteData(index) {
    contactModel.delContact(index);
    getData();
  }

  filterList(index) {
    CategoryController c1 = Get.find<CategoryController>();
    var cat = c1.categoery_data[index].category;
    return cat;
  }

  changefilter(value) {
    search.value = "";
    print("Before --${filter.value}--");
    if (filter.value == value) {
      filter.value = '';
    } else {
      filter.value = value;
    }
    print("After --${filter.value}--");
    update();
  }

  searchData(value) {
    filter.value = "";
    search.value = value;
  }
}
