import 'package:ipsb_visitor_app/src/models/account.dart';
import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/models/shopping_item.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shopping_list.g.dart';

@JsonSerializable()
class ShoppingList {
  final int? id;
  final int? buildingId;
  final Building? building;
  final int? accountId;
  final Account? account;
  final String? name;
  final DateTime? shoppingDate;
  final String? status;
  final List<ShoppingItem>? shoppingItems;

  List<Store> getListStores() {
    if (shoppingItems == null) return [];

    Map<int, Store> stores = {};
    shoppingItems!.forEach((e) {
      final store = stores.putIfAbsent(
        e.product!.store!.id!,
        () => e.product!.store!,
      );
      if (store.products == null) {
        store.products = [];
      }
      e.product!.note = e.note;
      bool isProductExist = store.products!.indexWhere(
            (element) => element.id == e.product!.id,
          ) ==
          -1;
      if (isProductExist) {
        store.products!.add(e.product!);
      }
    });
    return stores.values.toList();
  }

  ShoppingList({
    this.accountId,
    this.account,
    this.id,
    this.buildingId,
    this.name,
    this.shoppingDate,
    this.status,
    this.building,
    this.shoppingItems,
  });
  factory ShoppingList.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListToJson(this);
}
