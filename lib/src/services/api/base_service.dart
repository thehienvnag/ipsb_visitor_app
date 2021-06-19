import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:indoor_positioning_visitor/src/data/api_helper.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';

abstract class BaseService {
  IApiHelper _apiHelper = Get.find();
  dynamic fromJson(Map<String, dynamic> json);
  String endpoint();

  Future<Paging> getAllBase(Map<String, dynamic> query) async {
    Response res = await _apiHelper.getAll(endpoint(), query: query);
    Paging paging = Paging.fromJson(res.body);
    paging.convertToList(fromJson);
    return paging;
  }
}
