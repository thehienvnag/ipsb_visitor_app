class Endpoints {
  static const String apiVer = "api";
  static const String apiVer1 = "api/v1.0";
  static const todos = "todos";

  /// Version /api
  static const testUploadFile = '$apiVer/TestUploadFile';

  /// Product category endpoint version /api/v1
  static const productCategories = '$apiVer1/product-categories';

  /// Edge enpoint version /api/v1
  static const edges = '$apiVer1/edges';

  /// Edge enpoint version /api/v1
  static const locations = '$apiVer1/locations';

  /// Store enpoint version /api/v1
  static const stores = '$apiVer1/stores';

  /// Product enpoint version /api/v1
  static const products = '$apiVer1/products';

  /// Coupon enpoint version /api/v1
  static const coupons = '$apiVer1/coupons';

  /// FloorPlan enpoint version /api/v1
  static const floorPlans = '$apiVer1/floor-plans';

  /// Buidling enpoint version /api/v1
  static const buildings = '$apiVer1/buildings';

  /// CouponInUse enpoint version /api/v1
  static const couponsInUse = '$apiVer1/coupon-in-uses';

  /// ProductCategory enpoint version /api/v1
  static const productCategory = '$apiVer1/product-categories';

  /// Account enpoint version /api/v1
  static const accounts = '$apiVer1/accounts';

  /// Login via firebase endpoint version /api/v1
  static const loginFirebase = '$apiVer1/auth/login-firebase';

  /// Refresh token endpoint version /api/v1
  static const refreshToken = '$apiVer1/auth/refresh-token';

  /// Shopping list endpoint version /api/v1
  static const shoppingList = '$apiVer1/shopping-lists';

  /// Shopping item endpoint version /api/v1
  static const shoppingItem = '$apiVer1/shopping-items';
}
