import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/shopping_list.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/shopping_list_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

class ShoppingListDetailController extends GetxController {
  final IShoppingListService _shoppingListService = Get.find();
  final shoppingListDetails = ShoppingList().obs;
  final SharedStates _sharedStates = Get.find();

  @override
  void onInit() {
    super.onInit();
    loadShoppingListDetails();
  }

  void loadShoppingListDetails() async {
    String? shoppingListId = Get.parameters["shoppingListId"];
    if (shoppingListId == null) return;
    final result =
        await _shoppingListService.getById(int.parse(shoppingListId));
    if (result != null) {
      shoppingListDetails.value = result;
    }
  }

  bool checkDataPresent() => shoppingListDetails.value.id != null;

  void startShopping() {
    if (!checkDataPresent()) return;
    _sharedStates.shoppingList.value = shoppingListDetails.value;
    Get.toNamed(Routes.map);
  }
}
