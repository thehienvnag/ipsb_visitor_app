import 'package:hive/hive.dart';

part 'storage_list.g.dart';

class StorageList<T> {
  @HiveField(0)
  List<T> value;

  @HiveField(1)
  DateTime updatedTime;

  StorageList({
    required this.value,
    required this.updatedTime,
  });
}
