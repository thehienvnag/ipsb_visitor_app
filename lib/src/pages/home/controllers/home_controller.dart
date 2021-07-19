import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/building.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/product_category.dart';

import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/api/building_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/coupon_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/store_service.dart';

class HomeController extends GetxController {
  IStoreService storeService = Get.find();
  final ScrollController scrollController = ScrollController();
  final showSlider = true.obs;
  final buildingId = 0.obs;
  final listCategories = categories.obs;
  final buildings = [].obs;
  final listCoupon = <Coupon>[].obs;
  final listStore = <Store>[].obs;
  final listBuilding = <Building>[].obs;
  @override
  void onInit() {
    super.onInit();
    //if (!initPage()) return;
    initPage();
    getStores();
    getCoupons();
    getBuildings();
  }

  bool initPage() {
    scrollController.addListener(() {
      final fromTop = scrollController.position.pixels;
      if (fromTop > 10) {
        showSlider.value = false;
      } else if (fromTop == 0) {
        showSlider.value = true;
      }
    });
    String? id = Get.parameters['id'];
    if (id == null) return false;
    buildingId.value = int.parse(id);
    return true;
  }

  void gotoDetails() {
    Get.toNamed(Routes.buildingDetails);
  }

  Future<void> getStores() async {
    final stores = await storeService.getStoresByBuilding(1);
    listStore.value = stores.content ?? [];
  }

  ICouponService couponService = Get.find();
  Future<void> getCoupons() async {
    listCoupon.value = (await couponService.getCoupons()).content ?? [];
  }

  IBuildingService buildingService = Get.find();
  Future<void> getBuildings() async {
    listBuilding.value = (await buildingService.getBuildings());
  }
}

final categories = [
  ProductCategory(name: 'Cà phê', imageUrl: 'assets/images/icon_coffee.png'),
  ProductCategory(name: 'Trà sữa', imageUrl: 'assets/images/icon_milktea.png'),
  ProductCategory(name: 'Mua sắm', imageUrl: 'assets/images/icon_shopping.png'),
  ProductCategory(
      name: 'Nhà hàng', imageUrl: 'assets/images/icon_restaurant.png'),
  ProductCategory(name: 'Xem phim', imageUrl: 'assets/images/icon_cinema.png'),
];
