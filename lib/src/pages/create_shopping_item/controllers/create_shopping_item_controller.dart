import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/services/api/product_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

class CreateShoppingItemController extends GetxController {
  final selectedBuilding = Building().obs;
  final shoppingListId = 0.obs;
  final IProductService _productService = Get.find();
  final SharedStates sharedStates = Get.find();

  @override
  void onInit() {
    super.onInit();
    setShoppingListId();
  }

  Future<List<Product>> loadProducts([String? search]) async {
    String? buildingIdStr = Get.parameters["buildingId"];
    if (buildingIdStr == null) return [];
    int buildingId = int.parse(buildingIdStr);
    return _productService.searchByBuildingId(buildingId, search);
  }

  void setShoppingListId() {
    String? shoppingListIdStr = Get.parameters["shoppingListId"];
    if (shoppingListIdStr == null) return;
    shoppingListId.value = int.parse(shoppingListIdStr);
  }
}
