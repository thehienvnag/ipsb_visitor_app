class Paging<T> {
  final int? totalCount,
      pageSize,
      totalPage,
      currentPage,
      nextPage,
      previousPage;
  late final List<T>? content;
  List<dynamic>? rawContent;

  static Paging<T> defaultInstance<T>() {
    final paging = Paging<T>();
    paging.content = null;
    return paging;
  }

  Paging({
    this.totalCount = 0,
    this.pageSize = 0,
    this.totalPage = 0,
    this.currentPage = 0,
    this.nextPage = 0,
    this.previousPage = 0,
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
