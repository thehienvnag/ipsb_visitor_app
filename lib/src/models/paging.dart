import 'package:json_annotation/json_annotation.dart';

part 'paging.g.dart';

@JsonSerializable()
class Paging {
  final int? totalCount,
      pageSize,
      totalPage,
      currentPage,
      nextPage,
      previousPage;
  List<dynamic>? content;
  Paging({
    this.totalCount,
    this.pageSize,
    this.totalPage,
    this.currentPage,
    this.nextPage,
    this.previousPage,
    this.content,
  });

  /// Convert json array to list
  void convertToList(Function fromJson) {
    content = content?.map((x) => fromJson(x)).toList();
  }

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);

  Map<String, dynamic> toJson() => _$PagingToJson(this);
}
