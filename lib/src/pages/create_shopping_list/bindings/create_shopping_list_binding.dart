import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/create_shopping_list/controllers/create_shopping_list_controller.dart';

class CreateShoppingListBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<CreateShoppingListController>(
        () => CreateShoppingListController(),
        fenix: true);
  }
}
