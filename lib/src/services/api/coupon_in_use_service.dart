import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/coupon_in_use.dart';
import 'package:ipsb_visitor_app/src/models/paging.dart';
import 'package:ipsb_visitor_app/src/services/api/base_service.dart';

mixin ICouponInUseService {
  Future<Paging<CouponInUse>> getCouponInUseByVisitorId(int visitorId);
  Future<CouponInUse?> getByVisitorIdAndCouponId(int visitorId, int couponId);
  Future<CouponInUse?> createCouponInUse(CouponInUse couponInUse);
  Future<bool> putFeedbackCouponInUse(
      CouponInUse couponInUse, String filePath, int id);
  Future<Paging<CouponInUse>> getCouponInUseByStoreId(int storeId);
  Future<int> countCouponInUseByCouponId(Map<String, dynamic> data);
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
  Future<bool> putFeedbackCouponInUse(
      CouponInUse couponInUse, String filePath, int id) {
    return putWithOneFileBase(couponInUse.toJson(), filePath, id);
  }

  @override
  Future<Paging<CouponInUse>> getCouponInUseByStoreId(int storeId) {
    return getPagingBase({
      'storeId': storeId.toString(),
      'status': "Used",
    });
  }

  Future<int> countCouponInUseByCouponId(Map<String, dynamic> data) {
    return countBase(data);
  }
}
