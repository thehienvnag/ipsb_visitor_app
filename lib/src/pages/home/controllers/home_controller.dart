import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/data/api_helper.dart';
import 'package:indoor_positioning_visitor/src/data/file_upload_utils.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';
import 'package:indoor_positioning_visitor/src/models/product_category.dart';
import 'package:indoor_positioning_visitor/src/models/todo.dart';

class HomeController extends GetxController {
  /// Find ApiHelper instance which has been registered
  IApiHelper _apiHelper = Get.find();
  final _imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Call getTodoList from beginning
    // getTodoList();
  }

  /// To do list values from API
  final todoList = [].obs;

  /// Get product categories
  final productCategories = [].obs;

  /// Image picked from android
  final image = ''.obs;

  /// Data input
  final data = {}.obs;

  /// Change Data input with [field] and [name]
  void inputData(String field, String value) {
    data.putIfAbsent(field, () => value);
  }

  /// create category
  Future<void> createCategory() async {
    Response res = await _apiHelper.postOne(Endpoints.productCategory, data);
    print(res.body);
  }

  /// Get todo list
  Future<void> getTodoList() async {
    Response res = await _apiHelper.getAll(Endpoints.todos);
    todoList.clear();
    todoList.addAll(
      _apiHelper.convertToList<Todo>(res.body, (json) => Todo.fromJson(json)),
    );
    print(todoList);
  }

  /// Get product categories
  Future<void> getProductCategories() async {
    Response res = await _apiHelper.getAll(Endpoints.productCategory);
    Paging paging = Paging.fromJson(res.body);
    productCategories.value = _apiHelper.convertToList(
        paging.content, (json) => ProductCategory.fromJson(json));
    print(productCategories);
  }

  /// Pick image
  Future<void> pickImage() async {
    var picked = await _imagePicker.getImage(source: ImageSource.gallery);
    if (picked != null) {
      image.value = picked.path;
    }
  }

  Future<void> uploadImage() async {
    MultipartFile file =
        FileUploadUtils.convertToMultipart(image.value, 'file');
    Response res =
        await _apiHelper.postOneWithFile(Endpoints.testUploadFile, file);
    print(res.body);
  }
}
