import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/product_detail/controllers/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<ProductDetailController>(() => ProductDetailController(),
        fenix: true);
  }
}
