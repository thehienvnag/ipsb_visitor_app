import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/shopping_list.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/shopping_list_service.dart';
import 'package:ipsb_visitor_app/src/utils/firebase_helper.dart';

class ShoppingListController extends GetxController {
  final shoppingLists = <ShoppingList>[].obs;
  final IShoppingListService _iShoppingListService = Get.find();
  final loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadShoppingLists();
  }

  void loadShoppingLists() async {
    // if (!AuthServices.isLoggedIn()) return;
    // shoppingLists.value = await _iShoppingListService
    //     .getByAccountId(AuthServices.userLoggedIn.value.id!);
    loading.value = true;
    shoppingLists.value = await _iShoppingListService.getByAccountId(18);
    if (shoppingLists.value.isNotEmpty) {
      FirebaseHelper helper = FirebaseHelper();
      for(var item in shoppingLists.value) {
        await helper.subscribeToTopic("shopping_list_id_" + item.id.toString());
      }
    }
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
      FirebaseHelper helper = FirebaseHelper();
      await helper.unsubscribeFromTopic("shopping_list_id_" + id.toString());
      loadShoppingLists();
    }
  }
}
