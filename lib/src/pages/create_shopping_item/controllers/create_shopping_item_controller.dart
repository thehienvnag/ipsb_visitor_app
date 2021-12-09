import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/product_service.dart';
import 'package:ipsb_visitor_app/src/services/api/shopping_item_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

class CreateShoppingItemController extends GetxController {
  final selectedBuilding = Building().obs;
  final shoppingListId = 0.obs;
  final IProductService _productService = Get.find();
  final SharedStates sharedStates = Get.find();
  final IShoppingItemService _shoppingItemService = Get.find();

  final productId = 0.obs;
  final note = "".obs;
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

  void setProduct(Product? product) {
    if (product != null && product.id != null) {
      productId.value = product.id!;
    } else {
      productId.value = 0;
    }
  }

  void submitForm() async {
    if (shoppingListId.value == 0) {
      BotToast.showText(
          text: "Shopping list did't exist!",
          textStyle: TextStyle(fontSize: 16, color: Color(0xffffffff)),
          duration: const Duration(seconds: 3));
    }
    if (productId.value == 0) {
      BotToast.showText(
          text: "Select product!",
          textStyle: TextStyle(fontSize: 16, color: Color(0xffffffff)),
          duration: const Duration(seconds: 3));
    } else if (note.value.isEmpty) {
      BotToast.showText(
          text: "Enter note shopping item",
          textStyle: TextStyle(fontSize: 16, color: Color(0xffffffff)),
          duration: const Duration(seconds: 3));
    } else {
      final data = {
        "productId": productId.value,
        "note": note.value,
        "shoppingListId": shoppingListId.value,
      };
      BotToast.showLoading();
      final result = await _shoppingItemService.create(data);
      BotToast.closeAllLoading();
      if (result != null) {
        BotToast.showText(text: "Successfully added shopping item");
        Get.back(result: true);
      }
    }
  }

  void goToProductDetails(int? id) {
    if (id == null) return;
    Get.toNamed(
      Routes.productDetail,
      parameters: {'productId': id.toString()},
    );
  }
}
