import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/combo_product_detail/controllers/combo_product_detail_controller.dart';

class ComboProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<ComboProductDetailController>(
        () => ComboProductDetailController(),
        fenix: true);
  }
}
