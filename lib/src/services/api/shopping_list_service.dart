import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/shopping_list.dart';
import 'base_service.dart';

mixin IShoppingListService {
  Future<List<ShoppingList>> getByAccountId(int? accountId);
  Future<ShoppingList?> getById(int id);
  Future<ShoppingList?> create(Map<String, dynamic> body);
  Future<bool> delete(int id);
  Future<bool> completeShopping(int id);
}

class ShoppingListService extends BaseService<ShoppingList>
    with IShoppingListService {
  @override
  String endpoint() {
    return Endpoints.shoppingList;
  }

  @override
  ShoppingList fromJson(Map<String, dynamic> json) {
    return ShoppingList.fromJson(json);
  }

  @override
  Future<List<ShoppingList>> getByAccountId(int? accountId) {
    return getAllBase({
      "accountId": accountId.toString(),
      "notStatus": "Inactive",
    });
  }

  @override
  Future<ShoppingList?> getById(int id) {
    return getByIdBase(id);
  }

  @override
  Future<ShoppingList?> create(Map<String, dynamic> body) {
    return postBase(body);
  }

  @override
  Future<bool> delete(int id) {
    return deleteBase(id);
  }

  @override
  Future<bool> completeShopping(int id) {
    return putAppendUri(id, "complete");
  }
}
