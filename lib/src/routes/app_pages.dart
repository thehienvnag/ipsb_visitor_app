import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/store_details/bindings/store_details_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/store_details/views/store_details_page.dart';
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
      name: Routes.storeDetails,
      page: () => StoreDetailsPage(),
      binding: StoreDetailsBinding(),
    ),
  ];
}
