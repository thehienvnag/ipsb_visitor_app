import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/shopping_list.dart';
import 'package:ipsb_visitor_app/src/services/api/shopping_list_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';

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
    loading.value = false;
  }
}
