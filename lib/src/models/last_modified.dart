import 'package:hive/hive.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';

part 'last_modified.g.dart';

@HiveType(typeId: AppHiveType.lastModifiedHeader)
class LastModified {
  @HiveField(0)
  final String? lastModified;

  @HiveField(1)
  final DateTime? updateTime;

  LastModified({this.lastModified, this.updateTime});
}
