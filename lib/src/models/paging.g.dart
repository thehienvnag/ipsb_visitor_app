// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paging _$PagingFromJson(Map<String, dynamic> json) {
  return Paging(
    totalCount: json['totalCount'] as int?,
    pageSize: json['pageSize'] as int?,
    totalPage: json['totalPage'] as int?,
    currentPage: json['currentPage'] as int?,
    nextPage: json['nextPage'] as int?,
    previousPage: json['previousPage'] as int?,
    content: json['content'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$PagingToJson(Paging instance) => <String, dynamic>{
      'totalCount': instance.totalCount,
      'pageSize': instance.pageSize,
      'totalPage': instance.totalPage,
      'currentPage': instance.currentPage,
      'nextPage': instance.nextPage,
      'previousPage': instance.previousPage,
      'content': instance.content,
    };
