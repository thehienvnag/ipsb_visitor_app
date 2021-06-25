import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/common/constants.dart';

mixin IApiHelper {
  // Get all from an API [endpoint] using [uri] and [query]
  Future<Response> getAll<T>(
    String uri, {
    Map<String, dynamic> query = Constants.defaultPagingQuery,
  });

  /// Get 1 by Id from API [endpoint] using [uri] and [id]
  Future<Response> getById(String endpoint, dynamic id);

  /// Post 1 to API [endpoint] providing [data]
  Future<Response> postOne(
    String endpoint,
    Map<String, dynamic> data,
  );

  /// Post 1 to API [endpoint] providing [data] with many files [files]
  Future<Response> postOneWithFiles(
    String endpoint,
    Map<String, dynamic> data,
    List<MultipartFile> files,
  );

  /// Post 1 to API [endpoint] providing [data] with many files [files]
  Future<Response> postOneWithFile(
    String endpoint,
    Map<String, dynamic> data,
    MultipartFile file,
  );

  /// Put 1 to API [endpoint] providing [id] and [data]
  Future<Response> putOne(
    String endpoint,
    dynamic id,
    Map<String, dynamic> data,
  );

  /// Put 1 to API [endpoint] providing [data] with one file [files]
  Future<Response> putOneWithOneFile(
    String endpoint,
    Map<String, dynamic> data,
    MultipartFile file,
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
  List<T> convertToList<T>(dynamic body, Function fromJson);
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
  Future<Response> getById(String endpoint, dynamic id) {
    return get('$endpoint/$id');
  }

  @override
  Future<Response> postOne(String endpoint, Map<String, dynamic> data) {
    return post(endpoint, data);
  }

  @override
  Future<Response> postOneWithFile(
    String endpoint,
    Map<String, dynamic> data,
    MultipartFile file,
  ) {
    var form = FormData(data);
    form.files.add(MapEntry('file', file));
    return post(endpoint, form);
  }

  @override
  Future<Response> postOneWithFiles(
    String endpoint,
    Map<String, dynamic> data,
    List<MultipartFile> files,
  ) {
    var form = FormData(data);
    files.forEach((file) {
      form.files.add(MapEntry('files', file));
    });
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
  Future<Response> putOneWithOneFile(
    String endpoint,
    Map<String, dynamic> data,
    MultipartFile file,
  ) {
    var form = FormData(data);
    form.files.add(MapEntry('files', file));

    return put(endpoint, form);
  }

  @override
  Future<Response> putOneWithFiles(
    String endpoint,
    Map<String, dynamic> data,
    List<MultipartFile> files,
  ) {
    var form = FormData(data);
    files.forEach((file) {
      form.files.add(MapEntry('files', file));
    });
    return put(endpoint, form);
  }

  @override
  Future<Response> deleteOne(String endpoint, dynamic id) {
    return delete('$endpoint/$id');
  }

  @override
  List<T> convertToList<T>(body, Function fromJson) {
    return (body as List).map<T>((x) => fromJson(x)).toList();
  }
}
