import 'package:com.ipsb.visitor_app/src/common/endpoints.dart';
import 'package:com.ipsb.visitor_app/src/models/paging.dart';
import 'package:com.ipsb.visitor_app/src/models/product_category.dart';
import 'package:com.ipsb.visitor_app/src/services/api/base_service.dart';

mixin IProductCategoryService {
  Future<Paging<ProductCategory>> getProductCategory();
}

class ProductCategoryService extends BaseService<ProductCategory>
    implements IProductCategoryService {
  @override
  String endpoint() {
    return Endpoints.productCategory;
  }

  @override
  ProductCategory fromJson(Map<String, dynamic> json) {
    return ProductCategory.fromJson(json);
  }

  @override
  Future<Paging<ProductCategory>> getProductCategory() {
    return getPagingBase({});
  }
}
