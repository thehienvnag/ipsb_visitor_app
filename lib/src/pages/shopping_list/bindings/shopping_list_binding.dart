import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/shopping_list/controllers/shopping_list_controller.dart';

class ShoppingListBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<ShoppingListController>(() => ShoppingListController(),
        fenix: true);
  }
}
