import 'package:hive/hive.dart';
import 'package:com.ipsb.visitor_app/src/common/constants.dart';
import 'package:com.ipsb.visitor_app/src/models/storage_list.dart';

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
    var dataStored = box.get(key);
    // In case data is not present in store, retrieve data from API callback
    final dataFromAPI = await apiCallback.call();
    // Data to store
    dataStored = StorageList(
      value: transformData != null ? transformData(dataFromAPI) : dataFromAPI,
      updatedTime: DateTime.now(),
    );
    box.put(key, dataStored);
    // if (dataStored == null) {
    //   final dataFromAPI = await apiCallback.call();
    //   // Data to store
    //   dataStored = StorageList(
    //     value: dataFromAPI,
    //     updatedTime: DateTime.now(),
    //   );
    //   box.put(key, dataStored);
    //   print("StorageList<" + T.toString() + ">: Fetch API!");
    // } else {
    //   print("StorageList<" + T.toString() + ">: Cached hit!");
    // }
    return dataStored.value;
  }
}
