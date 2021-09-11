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
  final storeId = 0.obs;
  @override
  void onInit() {
    super.onInit();
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

  void gotoProductDetails() {
    Get.toNamed(
      Routes.productDetail,
      // parameters: {'productId': product.id.toString()},
    );
  }

  void gotoProductComboDetails() {
    Get.toNamed(
      Routes.productComboDetail,
      // parameters: {'productId': product.id.toString()},
    );
  }
}
