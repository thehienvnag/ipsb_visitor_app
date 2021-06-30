import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';
import 'package:indoor_positioning_visitor/src/models/product_category.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin IProductCategoryService {
  Future<Paging<ProductCategory>> getProductCategory();
}

class ProductCategoryService extends BaseService<ProductCategory> implements IProductCategoryService {
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
