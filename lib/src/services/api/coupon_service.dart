import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';
import 'package:ipsb_visitor_app/src/models/paging.dart';
import 'package:ipsb_visitor_app/src/services/api/base_service.dart';

mixin ICouponService {
  Future<List<Coupon>> getCouponsByStoreId(int storeId);
  Future<Paging<Coupon>> getCoupons();
  Future<List<Coupon>> searchCoupons(
    String keySearch, {
    double? lat,
    double? lng,
  });
  Future<List<Coupon>> getCouponsByBuildingId(
    int storeId, {
    bool random = false,
  });
  Future<List<Coupon>> getCounponsByFloorPlanId(int floorPlanId);
}

class CouponService extends BaseService<Coupon> implements ICouponService {
  @override
  String endpoint() {
    return Endpoints.coupons;
  }

  @override
  Coupon fromJson(Map<String, dynamic> json) {
    return Coupon.fromJson(json);
  }

  @override
  Future<List<Coupon>> getCouponsByStoreId(int storeId) {
    return getAllBase(
      {
        'storeId': storeId.toString(),
        'checkLimit': 'true',
        'lowerExpireDate': DateTime.now().toString(),
        'isAll': 'true',
      },
    );
  }

  @override
  Future<Paging<Coupon>> getCoupons() async {
    return getPagingBase({
      'checkLimit': 'true',
      'isAll': 'true',
    });
  }

  @override
  Future<List<Coupon>> searchCoupons(
    String keySearch, {
    double? lat,
    double? lng,
  }) async {
    final params = {
      "isAll": "true",
      "searchKey": keySearch,
      'checkLimit': 'true',
      'lowerExpireDate': DateTime.now().toString(),
      'status': 'Active',
    };
    if (lat != null && lng != null) {
      params.putIfAbsent("lat", () => lat.toString());
      params.putIfAbsent("lng", () => lng.toString());
    }
    return getAllBase(params);
  }

  @override
  Future<List<Coupon>> getCouponsByBuildingId(
    int buildingId, {
    bool random = false,
  }) {
    final params = {
      'buildingId': buildingId.toString(),
      'lowerExpireDate': DateTime.now().toString(),
      'status': 'Active',
    };
    if (random) {
      params.putIfAbsent("random", () => "true");
    }
    return getAllBase(params);
  }

  @override
  Future<List<Coupon>> getCounponsByFloorPlanId(int floorPlanId) {
    return getAllBase({
      "floorPlanId": floorPlanId.toString(),
      "isAll": "true",
    });
  }
}
