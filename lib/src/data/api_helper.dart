import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/common/constants.dart';

mixin IApiHelper {
  // Get all from an API [endpoint] using [uri] and [query]
  Future<Response> getAll<T>(
    String uri, {
    Map<String, dynamic> query = Constants.defaultPagingQuery,
  });

  /// Get 1 by Id from API [endpoint] using [uri] and [id]
  Future<Response> getById<T>(String endpoint, dynamic id);

  /// Post 1 to API [endpoint] providing [data]
  Future<Response> postOne(String endpoint, Map data);

  /// Post 1 to API [endpoint] providing [data] with many files [files]
  Future<Response> postOneWithFiles(
    String endpoint,
    Map<String, dynamic> data,
    List<MultipartFile> files,
  );

  /// Post 1 to API [endpoint] providing [data] with many files [files]
  Future<Response> postOneWithFile(
    String endpoint,
    MultipartFile file, {
    Map<String, dynamic> data = Constants.noData,
  });

  /// Put 1 to API [endpoint] providing [id] and [data]
  Future<Response> putOne(
    String endpoint,
    dynamic id,
    Map<String, dynamic> data,
  );

  /// Put 1 to API [endpoint] providing [data] with many files [files]
  Future<Response> putOneWithFiles(
    String endpoint,
    Map<String, dynamic> data,
    List<MultipartFile> files,
  );

  /// Delete from API [endpoint] with [id]
  Future<Response> deleteOne(String endpoint, dynamic id);

  /// Convert json array to list
  List<T> convertToList<T>(dynamic body, Function fromJson) {
    return (body as List).map<T>((x) => fromJson(x)).toList();
  }
}

/// Class for calling HTTP methods
class ApiHelper extends GetConnect with IApiHelper {
  @override
  void onInit() {
    super.onInit();

    // Set baseUrl & timeout for API call
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
  }

  @override
  Future<Response> getAll<T>(
    String uri, {
    Map<String, dynamic>? query = Constants.defaultPagingQuery,
  }) {
    return get<T>(uri, query: query);
  }

  @override
  Future<Response> getById<T>(String endpoint, dynamic id) {
    return get<T>('$endpoint/$id');
  }

  @override
  Future<Response> postOne(String endpoint, Map data) {
    return post(endpoint, data);
  }

  @override
  Future<Response> postOneWithFiles(
    String endpoint,
    Map<String, dynamic> data,
    List<MultipartFile> files,
  ) {
    // Add multipart files to form body
    data.putIfAbsent('files', () => files);

    var form = FormData(data);
    return post(endpoint, form);
  }

  @override
  Future<Response> putOne(
    String endpoint,
    dynamic id,
    Map<String, dynamic> data,
  ) {
    return put('$endpoint$id', data);
  }

  @override
  Future<Response> putOneWithFiles(
    String endpoint,
    Map<String, dynamic> data,
    List<MultipartFile> files,
  ) {
    // Add multipart files to form body
    data.putIfAbsent('files', () => files);

    var form = FormData(data);
    return put(endpoint, form);
  }

  @override
  Future<Response> deleteOne(String endpoint, dynamic id) {
    return delete('$endpoint/$id');
  }

  @override
  Future<Response> postOneWithFile(
    String endpoint,
    MultipartFile file, {
    Map<String, dynamic> data = Constants.noData,
  }) {
    var form = FormData(data);
    form.files.add(MapEntry('file', file));
    return post(endpoint, form);
  }
}
