import 'package:hive/hive.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/storage_list.dart';

class ApiCacheResponse<T> {
  final List<T> value;
  final String? ifModifiedSince;

  ApiCacheResponse({
    this.value = const [],
    this.ifModifiedSince,
  });
}

class HiveStorage {
  static Future<List<T>> useStorageList<T>({
    required Future<ApiCacheResponse<T>?> Function(String?) apiCallback,
    required String key,
    required String storageBox,
    List<T> Function(List<T>)? transformData,
  }) async {
    // Get data stored in box
    StorageList<T>? dataStored;
    String timeKey = key + "_Time";
    // Open data box with storage box name
    final box = await Hive.openLazyBox<StorageList<T>>(storageBox);

    final timeBox =
        await Hive.openLazyBox<String>(StorageConstants.ifModifiedBox);

    final ifModifiedSince = await timeBox.get(timeKey);
    // In case data is not present in store, retrieve data from API callback
    try {
      final dataFromAPI = await apiCallback.call(ifModifiedSince);
      if (dataFromAPI != null && dataFromAPI.value.isNotEmpty) {
        dataStored = StorageList(
          value: transformData != null
              ? transformData(dataFromAPI.value)
              : dataFromAPI.value,
        );
        box.put(key, dataStored);
        if (dataFromAPI.ifModifiedSince != null) {
          timeBox.put(timeKey, dataFromAPI.ifModifiedSince!);
        }
      }
    } catch (e) {
      if (e == StorageConstants.dataNotModified) {
        dataStored = await box.get(key);
      }
    }
    return dataStored?.value ?? [];
  }
}
