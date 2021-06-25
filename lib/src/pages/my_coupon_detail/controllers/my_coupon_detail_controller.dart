import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class MyCouponDetailController extends GetxController {
  final SharedStates sharedStates = Get.find();

  bool checkStatus(CouponInUse couponInUse,String status){
    bool result = false;
    if(couponInUse.status == status || sharedStates.coupon.value.name != null){
      result = true;
    }
    return result;
  }
}
