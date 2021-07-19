import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin ICouponInUseService {
  Future<Paging<CouponInUse>> getCouponInUseByVisitorId(int visitorId);
  Future<CouponInUse?> getByVisitorIdAndCouponId(int visitorId, int couponId);
  Future<CouponInUse?> createCouponInUse(CouponInUse couponInUse);
  Future<CouponInUse?> putFeedbackCouponInUse(CouponInUse couponInUse);
}

class CouponInUseService extends BaseService<CouponInUse>
    implements ICouponInUseService {
  @override
  String endpoint() {
    return Endpoints.couponsInUse;
  }

  @override
  CouponInUse fromJson(Map<String, dynamic> json) {
    return CouponInUse.fromJson(json);
  }

  @override
  Future<Paging<CouponInUse>> getCouponInUseByVisitorId(int visitorId) {
    return getPagingBase({'visitorId': visitorId.toString()});
  }

  @override
  Future<CouponInUse?> createCouponInUse(CouponInUse couponInUse) {
    return postBase(couponInUse.toJson());
  }

  @override
  Future<CouponInUse?> getByVisitorIdAndCouponId(
      int visitorId, int couponId) async {
    final result = await getAllBase({
      'couponId': couponId.toString(),
      'visitorId': visitorId.toString(),
    });
    if (result.isNotEmpty) {
      return result.first;
    }
  }

  @override
  Future<CouponInUse?> putFeedbackCouponInUse(CouponInUse couponInUse) {
    List<String> files = [couponInUse.feedbackImage.toString()];
    return putWithFilesBase(couponInUse.toJson(), files);
  }
}
