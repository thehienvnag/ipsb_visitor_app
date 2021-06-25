import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import 'package:indoor_positioning_visitor/src/data/api_helper.dart';
import 'package:indoor_positioning_visitor/src/data/file_upload_utils.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';

abstract class BaseService<T> {
  IApiHelper _apiHelper = Get.find();

  /// Set decode function for entity
  T fromJson(Map<String, dynamic> json);

  /// Set api endpoint for entity
  String endpoint();
  Future<T> getByIdBase(int id) async {
    Response response = await _apiHelper.getById(endpoint(), id);
    return fromJson(response.body);
  }

  /// Get paging instance from API with [query]
  Future<Paging<T>> getPagingBase(Map<String, dynamic> query) async {
    Response res = await _apiHelper.getAll(endpoint(), query: query);
    Paging<T> paging = Paging.fromJson(res.body);
    paging.convertToList(fromJson);
    return paging;
  }

  /// Get list instances from API with [query]
  Future<List<T>> getAllBase(Map<String, dynamic> query) async {
    Response res = await _apiHelper.getAll(endpoint(), query: query);
    Paging<T> paging = Paging.fromJson(res.body);
    paging.convertToList(fromJson);
    return paging.content ?? [];
  }

  /// Post an instance with [body]
  Future<T> postBase(Map<String, dynamic> body) async {
    Response res = await _apiHelper.postOne(endpoint(), body);
    return fromJson(res.body);
  }

  /// Post an instance with [body]
  Future<T> postWithFilesBase(
    Map<String, dynamic> body,
    List<String> filePaths,
  ) async {
    List<MultipartFile> files = filePaths
        .map((path) => FileUploadUtils.convertToMultipart(path))
        .toList();
    Response res = await _apiHelper.postOneWithFiles(endpoint(), body, files);
    return fromJson(res.body);
  }

  /// Post an instance with [body]
  Future<T> postWithOneFileBase(
    Map<String, dynamic> body,
    String filePath,
  ) async {
    Response res = await _apiHelper.postOneWithFile(
      endpoint(),
      body,
      FileUploadUtils.convertToMultipart(filePath),
    );
    return fromJson(res.body);
  }

  /// Put an instance with [id] and [body]
  Future<T> putBase(dynamic id, Map<String, dynamic> body) async {
    Response res = await _apiHelper.putOne(endpoint(), id, body);
    return fromJson(res.body);
  }

  /// Put an instance with [body] and a file path [filePath]
  Future<T> putWithOneFileBase(
    Map<String, dynamic> body,
    String filePath,
  ) async {
    Response res = await _apiHelper.putOneWithOneFile(
      endpoint(),
      body,
      FileUploadUtils.convertToMultipart(filePath),
    );
    return fromJson(res.body);
  }

  /// Put an instance with [body]
  Future<T> putWithFilesBase(
    Map<String, dynamic> body,
    List<String> filePaths,
  ) async {
    List<MultipartFile> files = filePaths
        .map((path) => FileUploadUtils.convertToMultipart(path))
        .toList();
    Response res = await _apiHelper.putOneWithFiles(endpoint(), body, files);
    return fromJson(res.body);
  }

  /// Delete an instance
  Future<bool> deleteBase(dynamic id) async {
    Response res = await _apiHelper.deleteOne(endpoint(), id);
    return res.isOk;
  }
}
