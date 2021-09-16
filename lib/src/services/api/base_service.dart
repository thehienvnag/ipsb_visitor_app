import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import 'package:visitor_app/src/data/api_helper.dart';
import 'package:visitor_app/src/data/file_upload_utils.dart';
import 'package:visitor_app/src/models/paging.dart';
import 'package:visitor_app/src/services/global_states/auth_services.dart';

abstract class BaseService<T> {
  IApiHelper _apiHelper = Get.find();

  /// Set decode function for entity
  T fromJson(Map<String, dynamic> json);

  /// Set api endpoint for entity
  String endpoint();

  Future<T?> postNoAuth(String endpoint, Map<String, String> body) async {
    Response res = await _apiHelper.postOne(endpoint, body);
    if (res.statusCode == HttpStatus.ok) {
      return fromJson(res.body);
    }
  }

  Future<T?> getByIdBase(int id) async {
    final callback = () => _apiHelper.getById(endpoint(), id);
    Response response = await AuthServices.handleUnauthorized(callback);
    if (response.isOk) {
      return fromJson(response.body);
    }
  }

  /// Get paging instance from API with [query]
  Future<Paging<T>> getPagingBase(Map<String, dynamic> query) async {
    final callback = () => _apiHelper.getAll(endpoint(), query: query);
    Response res = await AuthServices.handleUnauthorized(callback);
    if (res.isOk) {
      Paging<T> paging = Paging.fromJson(res.body);
      paging.convertToList(fromJson);
      return paging;
    }
    return Paging.defaultInstance();
  }

  /// Get list instances from API with [query]
  Future<List<T>> getAllBase(Map<String, dynamic> query) async {
    Paging<T> paging = await getPagingBase(query);
    return paging.content ?? [];
  }

  /// Post an instance with [body]
  Future<T?> postBase(Map<String, dynamic> body) async {
    final callback = () => _apiHelper.postOne(endpoint(), body);
    Response res = await AuthServices.handleUnauthorized(callback);
    if (res.statusCode == HttpStatus.created) {
      return fromJson(res.body);
    }
  }

  /// Post an instance with [body]
  Future<T?> postWithFilesBase(
    Map<String, dynamic> body,
    List<String> filePaths,
  ) async {
    List<MultipartFile> files = filePaths
        .map((path) => FileUploadUtils.convertToMultipart(path))
        .toList();
    final callback = () => _apiHelper.postOneWithFiles(endpoint(), body, files);
    Response res = await AuthServices.handleUnauthorized(callback);
    if (res.statusCode == HttpStatus.created) {
      return fromJson(res.body);
    }
  }

  /// Post an instance with [body]
  Future<T?> postWithOneFileBase(
    Map<String, dynamic> body,
    String filePath,
  ) async {
    final callback = () => _apiHelper.postOneWithFile(
          endpoint(),
          body,
          FileUploadUtils.convertToMultipart(filePath),
        );
    Response res = await AuthServices.handleUnauthorized(callback);
    if (res.statusCode == HttpStatus.created) {
      return fromJson(res.body);
    }
  }

  /// Put an instance with [id] and [body]
  Future<bool> putBase(dynamic id, Map<String, dynamic> body) async {
    final callback = () => _apiHelper.putOne(endpoint(), id, body);
    Response res = await AuthServices.handleUnauthorized(callback);
    if (res.statusCode == HttpStatus.noContent) {
      return true;
    }
    return false;
  }

  /// Put an instance with [body] and a file path [filePath]
  Future<bool> putWithOneFileBase(
      Map<String, dynamic> body, String filePath, int id,
      [String fileName = "imageUrl"]) async {
    final callback = () => _apiHelper.putOneWithOneFile(
          endpoint() + "/" + id.toString(),
          body,
          FileUploadUtils.convertToMultipart(filePath),
          fileName,
        );
    Response res = await AuthServices.handleUnauthorized(callback);
    if (res.statusCode == HttpStatus.noContent) {
      return true;
    }
    return false;
  }

  /// Put an instance with [body]
  Future<bool> putWithFilesBase(
    Map<String, dynamic> body,
    List<String> filePaths,
  ) async {
    List<MultipartFile> files = filePaths
        .map((path) => FileUploadUtils.convertToMultipart(path))
        .toList();
    final callback = () => _apiHelper.putOneWithFiles(endpoint(), body, files);
    Response res = await AuthServices.handleUnauthorized(callback);
    if (res.statusCode == HttpStatus.noContent) {
      return true;
    }
    return false;
  }

  /// Delete an instance
  Future<bool> deleteBase(dynamic id) async {
    final callback = () => _apiHelper.deleteOne(endpoint(), id);
    Response res = await AuthServices.handleUnauthorized(callback);
    return res.statusCode == HttpStatus.noContent;
  }
}
