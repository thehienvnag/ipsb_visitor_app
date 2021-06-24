import 'package:get/get.dart';

import 'package:indoor_positioning_visitor/src/models/product.dart';
import 'package:indoor_positioning_visitor/src/pages/create-coupon/views/choose_products.dart';

class CreateCouponController extends GetxController {
  /// Current step
  final currentStep = 1.obs;

  /// Move to next step
  void moveToNext() {
    currentStep.value++;
  }

  /// Back to previous step
  void backToPrevious() {
    currentStep.value--;
  }

  /// Products
  final products = listProduct.obs;

  /// Chosen products
  final chosenProducts = <Product>[].obs;

  void chooseProducts() async {
    Get.to(() => ChooseProducts());
  }

  void choose(bool? isSelected, Product pro) {
    products.value = products.map((p) {
      if (p.id == pro.id) {
        p.isSelected = isSelected;
      }
      return p;
    }).toList();
    chosenProducts.value = products.where((p) => p.isSelected!).toList();
  }

  void clearChosen() {
    chosenProducts.value = [];
  }
}

List<Product> listProduct = [
  Product(
    id: 1,
    name: 'GOLDEN LOTUS TEA',
    description:
        'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
    price: 39000,
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Product(
    id: 2,
    name: 'GOLDEN LOTUS TEA',
    description:
        'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
    price: 39000,
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Product(
    id: 3,
    name: 'GOLDEN LOTUS TEA',
    description:
        'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
    price: 39000,
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
  Product(
    id: 4,
    name: 'GOLDEN LOTUS TEA',
    description:
        'Thức uống chinh phục những thực khách khó tính! Sự kết hợp độc đáo giữa trà Ô long, hạt sen thơm bùi và củ năng giòn tan. Thêm vào chút sữa sẽ để vị thêm ngọt ngào.',
    price: 39000,
    imageUrl:
        'https://www.highlandscoffee.com.vn/vnt_upload/product/03_2018/TRASENVANG.png',
  ),
];
