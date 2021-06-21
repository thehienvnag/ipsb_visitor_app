class Paging<T> {
  final int? totalCount,
      pageSize,
      totalPage,
      currentPage,
      nextPage,
      previousPage;
  late final List<T>? content;
  List<dynamic>? rawContent;

  Paging({
    this.totalCount,
    this.pageSize,
    this.totalPage,
    this.currentPage,
    this.nextPage,
    this.previousPage,
    this.rawContent,
  });

  /// Convert json array to list
  void convertToList(Function fromJson) {
    content = rawContent?.map<T>((x) => fromJson(x)).toList();
    rawContent = null;
  }

  factory Paging.fromJson(Map<String, dynamic> json) => Paging<T>(
        totalCount: json['totalCount'] as int?,
        pageSize: json['pageSize'] as int?,
        totalPage: json['totalPage'] as int?,
        currentPage: json['currentPage'] as int?,
        nextPage: json['nextPage'] as int?,
        previousPage: json['previousPage'] as int?,
        rawContent: json['content'] as List?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'totalCount': this.totalCount,
        'pageSize': this.pageSize,
        'totalPage': this.totalPage,
        'currentPage': this.currentPage,
        'nextPage': this.nextPage,
        'previousPage': this.previousPage,
        'content': this.content,
      };
}
