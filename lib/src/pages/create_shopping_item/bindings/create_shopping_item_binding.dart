import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/pages/create_shopping_item/controllers/create_shopping_item_controller.dart';

class CreateShoppingItemBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<CreateShoppingItemController>(
      () => CreateShoppingItemController(),
      fenix: true,
    );
  }
}
