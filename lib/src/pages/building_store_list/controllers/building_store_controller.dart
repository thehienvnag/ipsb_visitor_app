import 'package:get/get.dart';
import 'package:com.ipsb.visitor_app/src/models/product_category.dart';
import 'package:com.ipsb.visitor_app/src/models/store.dart';
import 'package:com.ipsb.visitor_app/src/routes/routes.dart';
import 'package:com.ipsb.visitor_app/src/services/api/product_category_service.dart';
import 'package:com.ipsb.visitor_app/src/services/api/store_service.dart';

class BuildingStoreController extends GetxController {
  IStoreService _storeService = Get.find();
  IProductCategoryService _categoryService = Get.find();

  /// Get list stores of building
  final listStore = <Store>[].obs;

  void goToStoreDetails(int? id) {
    if (id != null) {
      Get.toNamed(Routes.storeDetails, parameters: {"id": id.toString()});
    }
  }

  /// Get list Store by api from buildingID
  Future<void> getStore() async {
    final paging = await _storeService.getStoresByBuilding(12);
    listStore.value = paging.content!;
    for (int i = 0; i < listStore.length; i++) {
      listStoreByCategory.add(listStore[i]);
    }
  }

  /// Get list productCategory
  final listProductCategory = <ProductCategory>[].obs;

  /// Get list category by [listProductCategory]
  final listIndex = <SelectedIndex>[].obs;

  /// Get list ProductCategory by api
  Future<void> getProductCategory() async {
    final paging = await _categoryService.getProductCategory();
    listProductCategory.value = paging.content!;
    for (int i = 0; i < listProductCategory.length; i++) {
      listIndex.add(SelectedIndex(
          id: listProductCategory[i].id,
          select: false,
          category: listProductCategory[i]));
    }
  }

  /// Change Selected of Product Category
  void changeSelected(int? id) {
    if (id == null) {
      return;
    }
    listIndex.value = listIndex.map((item) {
      bool selected = false;
      if (id == item.id) selected = !item.select!;
      item.select = selected;
      return item;
    }).toList();
  }

  /// Get list stores of building by product category
  final listStoreByCategory = <Store>[].obs;

  /// Add data of product category choose to list stores
  void getStoreByCategory(bool selected, int cateId) {
    listStoreByCategory.clear();
    for (int i = 0; i < listStore.length; i++) {
      if (!selected) {
        listStoreByCategory.clear();
        for (int i = 0; i < listStore.length; i++) {
          listStoreByCategory.add(listStore[i]);
        }
      } else if (listStore[i].productCategoryId!.contains(cateId.toString())) {
        listStoreByCategory.add(listStore[i]);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getStore();
    getProductCategory();
  }
}

class SelectedIndex {
  final int? id;
  bool? select;
  ProductCategory? category;

  SelectedIndex({this.id, this.select, this.category});
}
