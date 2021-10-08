import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/pages/shopping_list_detail/controllers/shopping_list_detail_controller.dart';

class ShoppingListDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<ShoppingListDetailController>(
        () => ShoppingListDetailController(),
        fenix: true);
  }
}
