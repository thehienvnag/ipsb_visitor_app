import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:indoor_positioning_visitor/src/data/api_helper.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';

abstract class BaseService<T> {
  IApiHelper _apiHelper = Get.find();

  /// Set decode function for entity
  dynamic fromJson(Map<String, dynamic> json);

  /// Set api endpoint for entity
  String endpoint();

  /// Get paging instance from API with [query]
  Future<Paging> getPagingBase(Map<String, dynamic> query) async {
    Response res = await _apiHelper.getAll(endpoint(), query: query);
    Paging paging = Paging.fromJson(res.body);
    paging.convertToList(fromJson);
    return paging;
  }

  /// Get list instances from API with [query]
  Future<List<T>> getAllBase(Map<String, dynamic> query) async {
    Response res = await _apiHelper.getAll(endpoint(), query: query);
    Paging<T> paging = Paging.fromJson(res.body);
    paging.convertToList(fromJson);
    return paging.content?.cast<T>() ?? [];
  }
}
