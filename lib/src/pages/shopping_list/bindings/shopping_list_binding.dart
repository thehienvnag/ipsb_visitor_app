import 'package:ipsb_visitor_app/src/pages/shopping_list/controllers/shopping_list_controller.dart';
import 'package:get/get.dart';

class ShoppingListBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<ShoppingListController>(() => ShoppingListController(),
        fenix: true);
  }
}
