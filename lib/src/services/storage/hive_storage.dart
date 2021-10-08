import 'package:hive/hive.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/last_modified.dart';
import 'package:ipsb_visitor_app/src/models/storage_list.dart';

class HiveStorage {
  static Future<List<T>> useStorageList<T>({
    required Future<List<T>> Function() apiCallback,
    required String storageBoxName,
    required dynamic key,
    List<T> Function(List<T>)? transformData,
  }) async {
    // Open data box with storage box name
    final box = await Hive.openBox<StorageList<T>>(StorageConstants.edgeBox);
    // Get data stored in box
    StorageList<T>? dataStored;
    // In case data is not present in store, retrieve data from API callback
    try {
      final dataFromAPI = await apiCallback.call();
      dataStored = StorageList(
        value: transformData != null ? transformData(dataFromAPI) : dataFromAPI,
        updatedTime: DateTime.now(),
      );
      box.put(key, dataStored);
    } catch (e) {
      if (e == StorageConstants.dataNotModified) {
        dataStored = box.get(key);
      }
    }
    return dataStored?.value ?? [];
  }

  static Future<String?> getIfModifiedSinceHeader(String requestUri) async {
    final box =
        await Hive.openBox<LastModified>(StorageConstants.requestUriBox);
    final data = box.get(requestUri);

    if (data != null) {
      final isValid = DateTime.now()
          .isBefore(data.updateTime!.add(StorageConstants.expireDuration));
      if (isValid) {
        return data.lastModified;
      } else {
        box.delete(requestUri);
      }
    }
  }

  static String getEndpoint(Uri url) {
    String endpoint = url.path.toString();
    endpoint += url.query.isEmpty ? "" : '?${url.query}';
    return endpoint;
  }

  static void saveLastModifiedHeader(
      String? lastModified, String requestUri) async {
    if (lastModified != null) {
      final box =
          await Hive.openBox<LastModified>(StorageConstants.requestUriBox);
      await box.put(
        requestUri,
        LastModified(
          lastModified: lastModified,
          updateTime: DateTime.now(),
        ),
      );
    }
  }
}
