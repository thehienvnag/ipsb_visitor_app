import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/shopping_list.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/shopping_list_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

class ShoppingListController extends GetxController {
  final shoppingLists = <ShoppingList>[].obs;
  final IShoppingListService _iShoppingListService = Get.find();
  final SharedStates shareState = Get.find();

  final loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadShoppingLists();
  }

  void gotoShoppingListDetail(int id) async {
    await Get.toNamed(
      Routes.shoppingListDetail,
      parameters: {
        "shoppingListId": id.toString(),
      },
    );
    loadShoppingLists(true);
  }

  void loadShoppingLists([isReturn = false]) async {
    var userId = AuthServices.userLoggedIn.value.id;
    if (userId == null && !isReturn) return;
    if (!AuthServices.isLoggedIn()) return;
    loading.value = true;
    shoppingLists.value = await _iShoppingListService.getByAccountId(userId);
    loading.value = false;
  }

  void createShoppingList() async {
    final result = await Get.toNamed(Routes.createShoppingList);
    if (result is bool && result) {
      loadShoppingLists();
    }
  }

  void deleteShoppingList(int? id) async {
    if (id == null) return;
    Get.back();
    bool result = await _iShoppingListService.delete(id);
    if (result) {
      BotToast.showText(text: "Successfully removed!");
      loadShoppingLists();
      Get.offAllNamed(Routes.shoppingList);
    }else{
      BotToast.showText(text: "Remove failed");
    }
  }
}
