class Constants {
  static final String baseUrl = "https://ipsb.azurewebsites.net/";
  static final Duration timeout = Duration(seconds: 20);
  static const Map<String, dynamic> defaultPagingQuery = {
    'page': '1',
    'pageSize': '5'
  };
  static const Map<String, dynamic> noData = {};
}
