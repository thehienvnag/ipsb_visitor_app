import 'package:ipsb_visitor_app/src/pages/create_shopping_list/controllers/create_shopping_list_controller.dart';
import 'package:get/get.dart';

class CreateShoppingListBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<CreateShoppingListController>(
      () => CreateShoppingListController(),
      fenix: true,
    );
  }
}
