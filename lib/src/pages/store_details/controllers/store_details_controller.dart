import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/product.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/api/coupon_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/product_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/store_service.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

final dateTime = DateTime.now();

class StoreDetailsController extends GetxController {
  final store = Store().obs;
  final listProduct = <Product>[].obs;
  final listCoupon = <Coupon>[].obs;
  /// Shared data
  final SharedStates sharedData = Get.find();

  @override
  void onInit() {
    super.onInit();

    getStoreDetail();
    getProducts();
    getCoupons();
  }

  IStoreService storeService = Get.find();
  Future<void> getStoreDetail() async {
    ///int id = Get.parameters['id'] as int;
    store.value = await storeService.getStoreById(18);
  }

  IProductService productService = Get.find();
  Future<void> getProducts() async {
    listProduct.value = await productService.getProductsByStoreId(15);
  }

  ICouponService couponService = Get.find();
  Future<void> getCoupons() async {
    listCoupon.value = await couponService.getCouponsByStoreId(18);
  }

  void gotoCouponDetails(Coupon coupon) {
    sharedData.saveCoupon(coupon);
    Get.toNamed(Routes.couponDetail);
  }

}
