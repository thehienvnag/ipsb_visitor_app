import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';
import 'package:ipsb_visitor_app/src/models/coupon_in_use.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_in_use_service.dart';
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
  final listFeedbacks = <CouponInUse>[].obs;
  final listFeedbacked = <CouponInUse>[].obs;
  final storeId = 0.obs;
  final loading = false.obs;

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(vsync: this, length: 3);
    String? id = Get.parameters['id'];
    print(id);
    if (id == null) return;
    storeId.value = int.parse(id);
    loading.value = true;
    try {
      await Future.wait([
        getStoreDetail(),
        getProducts(),
        getCoupons(),
        getFeedback(),
      ]);
    } catch (e) {}
    loading.value = false;
  }

  ICouponInUseService couponInUseService = Get.find();
  Future<void> getFeedback() async {
    final paging = await couponInUseService.getCouponInUseByStoreId(storeId.value);
    listFeedbacks.value = paging.content!;
    for (int i = 0; i < listFeedbacks.length; i++) {
      if (listFeedbacks[i].feedbackReply.toString().compareTo('null') < 0) {
        listFeedbacked.add(listFeedbacks[i]);
      }
    }
    listFeedbacked.sort((a,b){
      return b.feedbackDate!.compareTo(a.feedbackDate!);
    });
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
    listProduct.value =
        await productService.getProductsByStoreId(storeId.value);
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
