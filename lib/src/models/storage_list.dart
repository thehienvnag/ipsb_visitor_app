import 'package:hive/hive.dart';

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

class StorageListAdapter<T> extends TypeAdapter<StorageList<T>> {
  StorageListAdapter({
    required this.typeId,
  });
  final int typeId;

  @override
  StorageList<T> read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StorageList(
      value: (fields[0] as List).cast<T>(),
      updatedTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, StorageList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.updatedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorageListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
