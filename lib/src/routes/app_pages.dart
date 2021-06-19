import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/test_algorithm/bindings/test_algorithm_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/test_algorithm/views/test_algorithm_page.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/pages/home/bindings/home_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/home/views/home_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.testAlgorithm,
      page: () => TestAlgorithmPage(),
      binding: TestAlgorithmBinding(),
    ),
  ];
}
