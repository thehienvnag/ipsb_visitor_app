import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_service.dart';
import 'package:ipsb_visitor_app/src/services/api/product_service.dart';
import 'package:ipsb_visitor_app/src/services/api/store_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

final dateTime = DateTime.now();

class StoreDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController;
  final store = Store().obs;
  final listProduct = <Product>[].obs;
  final listGroups = <Product>[].obs;
  final listCoupon = <Coupon>[].obs;
  final storeId = 0.obs;

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 3);
    String? id = Get.parameters['id'];
    print(id);
    if (id == null) return;
    storeId.value = int.parse(id);
    getStoreDetail();
    getProducts();
    getCoupons();
  }

  IStoreService storeService = Get.find();
  Future<void> getStoreDetail() async {
    final storeApi = await storeService.getStoreById(storeId.value);

    if (storeApi != null) {
      store.value = storeApi;
    }
  }

  IProductService productService = Get.find();
  Future<void> getProducts() async {
    final list = await productService.getProductsByStoreId(storeId.value);
    final listGroupIds = list
        .where((e) => e.productGroup?.id != null)
        .map((e) => e.productGroup!.id!)
        .toList();
    setListProduct(list, listGroupIds);
    setListProductGroup(list, listGroupIds);
  }

  void setListProduct(List<Product> list, List<int?> groupIds) {
    listProduct.value = list.where((e) => !groupIds.contains(e.id!)).toList();
  }

  void setListProductGroup(List<Product> list, List<int?> groupIds) {
    listGroups.value = list.where((e) => groupIds.contains(e.id!)).toList();
  }

  ICouponService couponService = Get.find();
  Future<void> getCoupons() async {
    listCoupon.value = await couponService.getCouponsByStoreId(storeId.value);
  }

  SharedStates shared = Get.find();
  void gotoCouponDetail(Coupon coupon) {
    shared.coupon.value = coupon;
    Get.toNamed(
      Routes.couponDetail,
      parameters: {'couponId': coupon.id.toString()},
    );
  }

  void gotoProductDetails(int? id) {
    if (id == null) return;
    Get.toNamed(
      Routes.productDetail,
      parameters: {'productId': id.toString()},
    );
  }
}
