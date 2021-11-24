import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';

import 'package:ipsb_visitor_app/src/data/api_helper.dart';
import 'package:ipsb_visitor_app/src/data/file_upload_utils.dart';
import 'package:ipsb_visitor_app/src/models/paging.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/services/storage/hive_storage.dart';

abstract class BaseService<T> {
  IApiHelper _apiHelper = Get.find();

  /// Set decode function for entity
  T fromJson(Map<String, dynamic> json);

  /// Set api endpoint for entity
  String endpoint();

  Future<bool> putAppendUri(
    int id,
    String appendUri, {
    Map<String, dynamic> data = const {},
  }) async {
    final callback = () => _apiHelper.putOne(
          endpoint(),
          id,
          data,
          appendUri: appendUri,
        );
    Response response = await AuthServices.handleUnauthorized(callback);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<bool> putPure(
    String endpoint,
    Map<String, dynamic> data,
    dynamic id,
  ) async {
    final callback = () => _apiHelper.putOne(endpoint, id, data);
    Response response = await AuthServices.handleUnauthorized(callback);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
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

  Future<T?> postNoAuth(String endpoint, Map<String, String> body) async {
    Response res = await _apiHelper.postOne(endpoint, body);
    if (res.statusCode == HttpStatus.ok) {
      return fromJson(res.body);
    }
  }

  Future<T?> getByEndpoint(String uri) async {
    final callback = () => _apiHelper.getById(endpoint(), uri);
    Response response = await AuthServices.handleUnauthorized(callback);
    if (response.isOk) {
      return fromJson(response.body);
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

    return Paging.defaultInstance<T>();
  }

  /// Get cache response with if-modified-since
  Future<ApiCacheResponse<T>?> getCacheResponse(
    Map<String, dynamic> query, {
    String? ifModifiedSince,
  }) async {
    final callback = () => _apiHelper.getAll(
          endpoint(),
          query: query,
          ifModifiedSince: ifModifiedSince,
        );
    Response res = await AuthServices.handleUnauthorized(callback);
    ApiCacheResponse<T>? cacheResponse;
    if (res.isOk) {
      Paging<T> paging = Paging.fromJson(res.body);
      paging.convertToList(fromJson);
      cacheResponse = ApiCacheResponse<T>(
        value: paging.content ?? [],
        ifModifiedSince: res.headers?["last-modified"],
      );
    }
    if (res.statusCode == HttpStatus.notModified) {
      throw StorageConstants.dataNotModified;
    }
    return cacheResponse;
  }

  String getCacheKey(Map<String, dynamic> query) {
    String cacheKey = "${endpoint()}?";
    bool first = true;
    query.forEach((key, value) {
      if (!first) {
        cacheKey += "&$key=$value";
      } else {
        first = false;
        cacheKey += "$key=$value";
      }
    });
    return cacheKey;
  }

  /// Get list instances from API with [query]
  Future<List<T>> getAllBase(
    Map<String, dynamic> query, {
    String? ifModifiedSince,
  }) async {
    Paging<T> paging = await getPagingBase(query);
    return paging.content ?? [];
  }

  /// Get list instances from API with [query]
  Future<int> countBase(Map<String, dynamic> query,
      [bool cacheAllow = false]) async {
    final callback = () => _apiHelper.count(endpoint() + "/count", query);
    Response res = await AuthServices.handleUnauthorized(callback);
    print("This is body " + res.body.toString());
    return res.body;
  }

  /// Post an instance with [body]
  Future<T?> postBase(Map<String, dynamic> body,
      [bool noResponse = false]) async {
    final callback = () => _apiHelper.postOne(endpoint(), body);
    Response res = await AuthServices.handleUnauthorized(callback);
    if (res.statusCode == HttpStatus.created && !noResponse) {
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
